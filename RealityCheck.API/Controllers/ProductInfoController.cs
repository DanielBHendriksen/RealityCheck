using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using RealityCheck.API.Models;

namespace RealityCheck.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductInfoController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get([FromQuery] string query)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                return BadRequest(new { Message = "Query paramter is required" });
            }

            if (query.ToLower().Contains("aeron"))
            {
                return Ok(new ProductInfo
                {
                    Name = "Herman Miller Aeron Chair",
                    Width = 0.65,
                    Height = 1.2,
                    Depth = 0.6,
                    ImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Herman_Miller_Aeron_Chair.jpg/640px-Herman_Miller_Aeron_Chair.jpg",
                    ModelUrl = null
                });
            }

            return NotFound(new { Message = "Product not found" });
        }
    }
}