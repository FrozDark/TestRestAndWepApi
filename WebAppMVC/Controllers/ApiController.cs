using Microsoft.AspNetCore.Mvc;
using TestExercise;

namespace WebAppMVC.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ApiController : ControllerBase
    {
        private readonly RestAPIClient _context;

        public ApiController(RestAPIClient context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IEnumerable<Product>> Get([FromQuery] string? pattern)
        {
            return await _context.GetProductsAsync(pattern);
        }

        [HttpPost]
        public Task<Product> Create([FromForm(Name = "name")]string name, [FromForm(Name = "descr")] string? description)
        {
            return _context.ProductPOSTAsync(name, description);
        }

        [HttpPut("{id}")]
        public Task<Product> Update([FromRoute]Guid id, [FromForm(Name = "name")] string name, [FromForm(Name = "descr")] string? description)
        {
            return _context.ProductPUTAsync(id, name, description);
        }

        [HttpDelete("{id}")]
        public Task<bool> Delete([FromRoute] Guid id)
        {
            return _context.ProductDELETEAsync(id);
        }
    }
}
