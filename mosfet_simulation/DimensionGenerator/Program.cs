using System;
using Pastel;

namespace DimensionGenerator {
    class Program {
        static void Main(string[] args) {
            // Console colors
            string text = "#3AC769";
            string number = "#FFFFFF";
            string heading = "#31A8FF";

            // *----------------- PARAMS -----------------* //
            // *------------------------------------------* // 
            Console.WriteLine("MOSFET Dimensions".Pastel(heading));
            Console.WriteLine("-----------------".Pastel(heading));

            Console.Write("→ Channel type   (p/n) = ".Pastel(text));
            char channelType = Console.ReadLine().ToLower()[0];

            Console.Write("→ Channel length  (nm) = ".Pastel(text));
            double channelWidth = Convert.ToDouble(Console.ReadLine());

            Console.Write("→ Oxide thickness (nm) = ".Pastel(text));
            double oxideThickness = Convert.ToDouble(Console.ReadLine());

            // *-------------- CALCULATIONS --------------* //
            // *------------------------------------------* // 

            //double channelWidth = 160;
            //double oxideThickness = 3;
            //char channelType = 'n';


            double perunit = channelWidth / 160; // scaling factor
            double surfaceThickness = 3 * perunit; // ----------------------TODO: find if it scales or same as width
            double rectH = 70 * perunit;
            double rectW = 300 * perunit;
            double poly1 = 50 * perunit; // Source
            double poly2 = 70 * perunit;
            double poly3 = 230 * perunit; // Channel width
            double poly4 = 250 * perunit;
            double poly5 = 300 * perunit; // Drain


            string dopeBase = "";
            string dopeEdge = "";
            if(channelType == 'n') {
                dopeBase = "Acceptor doping (p-type)";
                dopeEdge = "Donator doping (n-type)";
            } else if(channelType == 'p') {
                dopeBase = "Donator doping (p-type)";
                dopeEdge = "Acceptor doping (n-type)";
            } else {
                Console.WriteLine($"\n\n\nInvalid channel type: '{channelType}'. Accepted responses are 'p' and 'n'");
                Console.WriteLine("Restart the console app. Press any key to exit ...");
                Console.ReadLine();
                Environment.Exit(0);

            }


            // *----------------- OUTPUT -----------------* //
            // *------------------------------------------* // 
            Console.WriteLine("\nSteps to produce your MOSFET".Pastel(heading));
            Console.WriteLine("----------------------------".Pastel(heading));

            Console.WriteLine("→ Set length unit to nanometer (nm)\n".Pastel(text));

            // Rectangle
            Console.WriteLine($"→ Rectangle dimensions: {rectW.ToString().Pastel(number)} x {rectH.ToString().Pastel(number)}\n".Pastel(text));

            // Polygon
            Console.WriteLine($"→ Polygon (vector) dimensions:".Pastel(text));
            Console.Write($"    → x: ".Pastel(text));
            Console.WriteLine($"0 0 {poly1} {poly2} {poly3} {poly4} {poly5} {poly5}".Pastel(number));

            Console.Write($"    → y: ".Pastel(text));
            Console.WriteLine($"{rectH - surfaceThickness} {rectH} {rectH} {rectH} {rectH} {rectH} {rectH} {rectH - surfaceThickness}\n".Pastel(number));

            // Doping 1
            Console.WriteLine($"→ Analytic Doping Model 1".Pastel(text));
            Console.WriteLine($"    → {dopeBase.Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → {"1e17[1/cm^3]".Pastel(number)}\n".Pastel(text));

            // Doping 2
            Console.WriteLine($"→ Analytic Doping Model 2".Pastel(text));
            Console.WriteLine($"    → {dopeEdge.Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → {"1e20[1/cm^3]".Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → Base position (ro): {$"{0}, {60 * perunit}".Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → Width (W): {(60 * perunit).ToString().Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → Height (D): {(10 * perunit).ToString().Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → Junction depth (dj): {$"{20 * perunit}, {25 * perunit}".Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → Background doping concentration (Nb): {"1e17[1/cm^3]".Pastel(number)}\n".Pastel(text));

            // Doping 3
            Console.WriteLine($"→ Analytic Doping Model 3".Pastel(text));
            Console.WriteLine($"    → Copy-paste Analytic Doping Model 3".Pastel(text));
            Console.WriteLine($"    → Base position (ro): {$"{240 * perunit}, {60 * perunit}".Pastel(number)}\n".Pastel(text));

            // Metal contacts
            Console.WriteLine($"→ Metal Contact 1, 2, 3 → Follow video\n".Pastel(text));

            // Thin insulator gate
            Console.WriteLine($"→ Thin Insulator Gate 1".Pastel(text));
            Console.WriteLine($"    → Oxide relative permability (Eins): {"4.5".Pastel(number)}".Pastel(text));
            Console.WriteLine($"    → Oxide thickness (d_ins): {$"{oxideThickness}[nm]".Pastel(number)}\n".Pastel(text));

            // Final
            Console.WriteLine($"→ Follow video to complete design".Pastel(text));

            Console.WriteLine("\n\n\nPress any key to exit ...");
            Console.ReadLine();
        }
    }
}
