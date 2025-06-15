using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RealityCheck.API.Models
{
    public class ProductInfo
    {
        public string Name { get; set; }
        public double Width { get; set; } // in meters
        public double Height { get; set; }
        public double Depth { get; set; }
        public string? ImageUrl { get; set; }
        public string? ModelUrl { get; set; }
    }
}