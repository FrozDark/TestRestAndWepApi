using Microsoft.CodeAnalysis.Elfie.Diagnostics;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Reflection.Metadata;
using System.Runtime.ConstrainedExecution;
using System.Text.RegularExpressions;
using TestExercise.Models;

namespace TestWebApp
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) 
        { 
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<Product> ProductVersion { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // В базе есть триггеры, поэтому убираем OUTPUT
            modelBuilder.Entity<Product>()
                .ToTable(tb => tb.UseSqlOutputClause(false));
            modelBuilder.Entity<ProductVersion>()
                .ToTable(tb => tb.UseSqlOutputClause(false));
        }

        public static async Task ExecuteInitializationScripts(string? connectionString)
        {
            ArgumentNullException.ThrowIfNull(connectionString);

            await using var connection = new SqlConnection(connectionString);
            await connection.OpenAsync();

            async Task ExecuteScriptFile(string sqlFile)
            {
                var script = File.ReadAllText("SqlScripts/" + sqlFile);

                var commandStrings = Regex.Split(script, @"^\s*GO\s*$", RegexOptions.Multiline | RegexOptions.IgnoreCase);

                foreach (var commandString in commandStrings)
                {
                    var commandStringTrim = commandString.Trim();
                    if (!string.IsNullOrWhiteSpace(commandStringTrim))
                    {
                        await using (var command = new SqlCommand(commandStringTrim, connection))
                        {
                            command.ExecuteNonQuery();
                            //await using var reader = await command.ExecuteReaderAsync();
                        }
                    }
                }
            }

            await ExecuteScriptFile("create_TestDB.sql");
            await ExecuteScriptFile("create_table_Product.sql");
            await ExecuteScriptFile("create_table_ProductVersion.sql");
            await ExecuteScriptFile("create_stored_procedure_SearchVersion.sql");
            await ExecuteScriptFile("create_table_EventLogs.sql");
            await ExecuteScriptFile("create_log_triggers.sql");
            await ExecuteScriptFile("insert_arbitrary_data.sql");

            // Проверка нашей функции поиска
	        // @productName nvarchar(255), 
	        // @productVersionName nvarchar(255),
	        // @minValue real,
	        // @maxValue real
            await using (var command = new SqlCommand("SearchProductVersion", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@productName", SqlDbType.NVarChar, 255).Value = "гит";
                command.Parameters.Add("@productVersionName", SqlDbType.NVarChar, 255).Value = "2";
                command.Parameters.Add("@minValue", SqlDbType.Real).Value = 10000;
                command.Parameters.Add("@maxValue", SqlDbType.Real).Value = 30000;

                await using var reader = await command.ExecuteReaderAsync();
                if (!reader.HasRows)
                {
                    throw new InvalidOperationException();
                }

                // Выведет: versionID       name    versionName     height  width   length
                Console.WriteLine(string.Join('\t', Enumerable.Range(0, reader.FieldCount).Select(x => reader.GetName(x))));

                // Только один результат по базовым скриптам
                // d07448b5-ec60-499f-a692-89fb009ddeb2    Гитара  Версия номер 2  23,2    26,6    40,35
                while (await reader.ReadAsync())
                {
                    Console.WriteLine(string.Join('\t', Enumerable.Range(0, reader.FieldCount).Select(x => reader.GetValue(x).ToString())));
                }
            }
        }
    }
}
