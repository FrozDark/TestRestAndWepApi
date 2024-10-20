using Microsoft.AspNetCore.Mvc;
using TestExercise;

namespace WebAppMVC
{
    public class ProductsController : Controller
    {
        private readonly RestAPIClient _context;

        public ProductsController(RestAPIClient context)
        {
            _context = context;
        }

        // GET: Products
        public async Task<IActionResult> Index()
        {
            return View(await _context.GetProductsAsync(null));
        }
    }
}
