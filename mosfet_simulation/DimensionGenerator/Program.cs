using System;
using Pastel;

namespace DimensionGenerator {
    class Program {
        static void Main(string[] args) {
            // Console colors
            string text = "#3AC769";
            string value = "#FFFFFF";
            string heading = "#31A8FF";

            // *----------------- PARAMS -----------------* //
            // *------------------------------------------* // 
            Console.WriteLine("MOSFET Dimensions and Voltage".Pastel(heading));
            Console.WriteLine("-----------------------------".Pastel(heading));

            //Console.Write("→ Channel type   (p/n) = ".Pastel(text));
            //char channelType = Console.ReadLine().ToLower()[0];

            Console.Write("→ Channel length  (nm) = ".Pastel(text));
            double channelWidth = Convert.ToDouble(Console.ReadLine());

            Console.Write("→ Oxide thickness (nm) = ".Pastel(text));
            double oxideThickness = Convert.ToDouble(Console.ReadLine());

            // *-------------- CALCULATIONS --------------* //
            // *------------------------------------------* // 
            double perunit = channelWidth / 160;
            double rectH = 70 * perunit;
            double rectW = 300 * perunit;
            double poly1 = 50 * perunit; // Source
            double poly2 = 70 * perunit;
            double poly3 = 230 * perunit; // Channel width
            double poly4 = 250 * perunit;
            double poly5 = 300 * perunit; // Drain


            // *----------------- OUTPUT -----------------* //
            // *------------------------------------------* // 
            Console.WriteLine("\nSteps to produce your MOSFET".Pastel(heading));
            Console.WriteLine("----------------------------".Pastel(heading));

            Console.WriteLine("→ Set length unit to nanometer (nm)".Pastel(text));

            Console.WriteLine($"→ Rectangle dimensions:  {rectW.ToString().Pastel(value)} x {rectH.ToString().Pastel(value)}".Pastel(text));

            Console.Write($"→ Polygon coordinates x: ".Pastel(text));
            Console.WriteLine($"0 0 {poly1} {poly2} {poly3} {poly4} {poly5} {poly5}".Pastel(value));

            Console.Write($"→ Polygon coordinates y: ".Pastel(text));
            Console.WriteLine($"{rectH - oxideThickness} {rectH} {rectH} {rectH} {rectH} {rectH} {rectH} {rectH - oxideThickness}".Pastel(value));

            Console.ReadLine();
        }
    }
}
