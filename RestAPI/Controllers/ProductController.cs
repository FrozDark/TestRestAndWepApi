using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TestExercise.Models;

namespace TestWebApp.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly ILogger<ProductController> _logger;

        private readonly AppDbContext _dbContext;

        public ProductController(ILogger<ProductController> logger, AppDbContext dbContext)
        {
            _logger = logger;
            _dbContext = dbContext;
        }

        [HttpGet(Name = "GetProducts")]
        public async Task<IEnumerable<Product>> Get([FromQuery] string? pattern)
        {
            if (pattern is null)
            {
                return await _dbContext.Products.ToArrayAsync();
            }
            return await _dbContext.Products.Where(c => c.Name!.Contains(pattern!)).ToArrayAsync();
        }

        [HttpPost]
        public async Task<Product> CreateProductAsync([FromQuery] string name, [FromQuery] string? description)
        {
            var data = new Product()
            {
                Name = name,
                Description = description
            };

            await _dbContext.AddAsync(data);
            await _dbContext.SaveChangesAsync();

            return data;
        }

        [HttpPut("{id}")]
        public async Task<Product> UpdateProductAsync([FromRoute] Guid id, [FromQuery] string name, [FromQuery] string? description)
        {
            var product = await _dbContext.Products.SingleOrDefaultAsync(c => c.Id == id);

            ArgumentNullException.ThrowIfNull(nameof(product));

            product!.Name = name;
            product!.Description = description;

            await _dbContext.SaveChangesAsync();

            return product;
        }

        [HttpDelete("{id}")]
        public async Task<bool> DeleteProductAsync([FromRoute] Guid id)
        {
            var product = await _dbContext.Products.SingleOrDefaultAsync(c => c.Id == id);

            if (product is null)
            {
                return false;
            }

            _dbContext.Remove(product!);

            await _dbContext.SaveChangesAsync();

            return true;
        }
    }
}
