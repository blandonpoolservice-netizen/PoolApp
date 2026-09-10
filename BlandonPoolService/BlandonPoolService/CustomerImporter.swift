import Foundation
import SwiftData

struct CustomerImporter {

    static func importCustomers(
        into modelContext: ModelContext
    ) {
        do {
            let existingCustomers = try modelContext.fetch(
                FetchDescriptor<Customer>()
            )

            let existingNames = Set(
                existingCustomers.map {
                    $0.name.lowercased()
                }
            )

            for data in customerData {
                
                // Do not import the same customer twice.
                if existingNames.contains(data.name.lowercased()) {
                    continue
                }

                let customer = Customer(
                    name: data.name,
                    serviceDay: data.serviceDay,
                    monthlyPrice: data.monthlyPrice,
                    outstandingBalance: data.outstandingBalance,
                    paymentHandle: data.paymentHandle,
                    notes: data.notes
                )

                modelContext.insert(customer)
            }
            print("IMPORTER INSERT LOOP FINISHED")
            try modelContext.save()

            let verifyCustomers = try modelContext.fetch(
                FetchDescriptor<Customer>()
            )

            print("CUSTOMER IMPORT COMPLETED")
            print("Customer records in importer: \(customerData.count)")
            print("Customers before import: \(existingCustomers.count)")
            print("Customers after import: \(verifyCustomers.count)")

        } catch {
            print("Customer import failed: \(error)")
        }
    }


    private struct CustomerData {
        let name: String
        let serviceDay: String
        let monthlyPrice: Double
        let outstandingBalance: Double
        let paymentHandle: String
        let notes: String
    }


    private static let customerData: [CustomerData] = [

        CustomerData(
            name: "Galang",
            serviceDay: "Thursday",
            monthlyPrice: 220,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Beto",
            serviceDay: "Thursday",
            monthlyPrice: 370,
            outstandingBalance: 740,
            paymentHandle: "@Sabrina-Amaro-2",
            notes: ""
        ),

        CustomerData(
            name: "Betty",
            serviceDay: "Monday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Bowman",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Bruce",
            serviceDay: "Monday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Bryan Perez",
            serviceDay: "Monday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Calvin",
            serviceDay: "Monday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Cecilia",
            serviceDay: "Monday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Cheryl Bertsch",
            serviceDay: "Wednesday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Cristal",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Debbie Wood",
            serviceDay: "Thursday",
            monthlyPrice: 165,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Diane George",
            serviceDay: "Thursday",
            monthlyPrice: 165,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Eva",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Giordano",
            serviceDay: "Wednesday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Gum",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Jeff Oakdale",
            serviceDay: "Monday",
            monthlyPrice: 185,
            outstandingBalance: 530,
            paymentHandle: "510",
            notes: ""
        ),

        CustomerData(
            name: "Anthony Napoli",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 740,
            paymentHandle: "@napolianthony",
            notes: ""
        ),

        CustomerData(
            name: "Black",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@Catharine-Black",
            notes: ""
        ),

        CustomerData(
            name: "Cesar Mnt House",
            serviceDay: "Tuesday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "@Esther-Medina-6",
            notes: ""
        ),

        CustomerData(
            name: "Cheryl McFall / Hurney",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 555,
            paymentHandle: "@chermcfall",
            notes: ""
        ),

        CustomerData(
            name: "Fereira",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@Patricia-Fareria",
            notes: ""
        ),

        CustomerData(
            name: "Fraze",
            serviceDay: "Monday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "@Cynthia-Fraze",
            notes: ""
        ),

        CustomerData(
            name: "Gabriella Silveira",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "@Gabriella-Silveira",
            notes: ""
        ),

        CustomerData(
            name: "Gerald (Tanty)",
            serviceDay: "Tuesday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@Erika-NishimotoTanty",
            notes: ""
        ),

        CustomerData(
            name: "Grimm",
            serviceDay: "Thursday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "@coleygrimm",
            notes: ""
        ),

        CustomerData(
            name: "Jeff Pribble",
            serviceDay: "Thursday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@Lisa-Pribble-1",
            notes: ""
        ),

        CustomerData(
            name: "Jesenia Jamison",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 370,
            paymentHandle: "@Yesenia-Jamison",
            notes: ""
        ),

        CustomerData(
            name: "Jessica Rodriguez",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@arijessi",
            notes: ""
        ),

        CustomerData(
            name: "Joe Bilbao",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "@Joe-Bilbao",
            notes: ""
        ),

        CustomerData(
            name: "Angela Gregory",
            serviceDay: "Thursday",
            monthlyPrice: 70,
            outstandingBalance: 0,
            paymentHandle: "Angela Gregory",
            notes: ""
        ),

        CustomerData(
            name: "Babu (Belong Automotive)",
            serviceDay: "Thursday",
            monthlyPrice: 200,
            outstandingBalance: 0,
            paymentHandle: "Belong Automotive",
            notes: ""
        ),

        CustomerData(
            name: "Camara",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Cesar Cristian",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Claudia Garcia (Jorge)",
            serviceDay: "Tuesday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Criss (Crispin)",
            serviceDay: "Wednesday",
            monthlyPrice: 160,
            outstandingBalance: 320,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Desacampos",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 850,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Ergonis",
            serviceDay: "Wednesday",
            monthlyPrice: 165,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "Xmas"
        ),

        CustomerData(
            name: "Ford",
            serviceDay: "Wednesday",
            monthlyPrice: 185,
            outstandingBalance: 10,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Guru",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 160,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Jantz",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Junior Romero",
            serviceDay: "Thursday",
            monthlyPrice: 165,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Katie Kovenich",
            serviceDay: "Tuesday",
            monthlyPrice: 160,
            outstandingBalance: 320,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Kim Hong",
            serviceDay: "Tuesday",
            monthlyPrice: 185,
            outstandingBalance: 185,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Kim Simmons",
            serviceDay: "Tuesday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Konczal",
            serviceDay: "Wednesday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "KRISHNA YELUVOLU",
            serviceDay: "Wednesday",
            monthlyPrice: 180,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Ladian",
            serviceDay: "Wednesday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Lanny",
            serviceDay: "Wednesday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Lee vu",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "@Lee-Vu-2",
            notes: ""
        ),

        CustomerData(
            name: "Levitt",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "Xmas"
        ),

        CustomerData(
            name: "Loriane",
            serviceDay: "Tuesday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "@Lorie-Morse",
            notes: ""
        ),

        CustomerData(
            name: "Jim Murdaca",
            serviceDay: "Wednesday",
            monthlyPrice: 190,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Malene Latu",
            serviceDay: "Thursday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@MaleneLatu",
            notes: ""
        ),

        CustomerData(
            name: "Malik Rahman",
            serviceDay: "Wednesday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Marion Sangar",
            serviceDay: "Monday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Martin Macias",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@Ilda-Macias",
            notes: ""
        ),

        CustomerData(
            name: "Mckensie",
            serviceDay: "Monday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Melinda (Theresa Bragg)",
            serviceDay: "Thursday",
            monthlyPrice: 180,
            outstandingBalance: 0,
            paymentHandle: "@Theresa-Bragg-5",
            notes: ""
        ),

        CustomerData(
            name: "Melissa",
            serviceDay: "Monday",
            monthlyPrice: 320,
            outstandingBalance: 0,
            paymentHandle: "@Melissa-Heaslett",
            notes: ""
        ),

        CustomerData(
            name: "Miguel (Maribel Zamora)",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Monnie",
            serviceDay: "Wednesday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Mr Moses (MNM)",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 260,
            paymentHandle: "",
            notes: "Pool cleaner bearings"
        ),

        CustomerData(
            name: "Mr. Star",
            serviceDay: "Monday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Mrs. Yee",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Myke",
            serviceDay: "Wednesday",
            monthlyPrice: 185,
            outstandingBalance: 370,
            paymentHandle: "@Mrs-U",
            notes: ""
        ),

        CustomerData(
            name: "Orozco",
            serviceDay: "Monday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "@Brooke-Myall-1",
            notes: ""
        ),

        CustomerData(
            name: "Osborn",
            serviceDay: "Thursday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Osgood",
            serviceDay: "Thursday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "@Bryna-Osgood",
            notes: ""
        ),

        CustomerData(
            name: "Patricia",
            serviceDay: "Monday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Pedersen",
            serviceDay: "Thursday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "@Valerie-Pedersen-2",
            notes: ""
        ),

        CustomerData(
            name: "Anthoy Perez",
            serviceDay: "Monday",
            monthlyPrice: 130,
            outstandingBalance: 0,
            paymentHandle: "@Bernie-Perez-2",
            notes: ""
        ),

        CustomerData(
            name: "Perez (Haley G Doyal-Moyse)",
            serviceDay: "Thursday",
            monthlyPrice: 165,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Pratt",
            serviceDay: "Monday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Ramzia Kakar",
            serviceDay: "Tuesday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Richard Vanden Bosch",
            serviceDay: "Monday",
            monthlyPrice: 165,
            outstandingBalance: 495,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Ross",
            serviceDay: "Thursday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "@Elizabeth-Ross-44",
            notes: ""
        ),

        CustomerData(
            name: "Rushing",
            serviceDay: "Monday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "@Karen-Anson",
            notes: ""
        ),

        CustomerData(
            name: "Sombo Koo",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 45,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Jim Vierra",
            serviceDay: "Thursday",
            monthlyPrice: 200,
            outstandingBalance: 0,
            paymentHandle: "Jim-Vierra-1",
            notes: ""
        ),

        CustomerData(
            name: "Silva",
            serviceDay: "Thursday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "@GerriSilva09",
            notes: ""
        ),

        CustomerData(
            name: "Soligan",
            serviceDay: "Wednesday",
            monthlyPrice: 155,
            outstandingBalance: 0,
            paymentHandle: "@Carole-Soligan",
            notes: ""
        ),

        CustomerData(
            name: "Stan",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 370,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Stopka",
            serviceDay: "Tuesday",
            monthlyPrice: 190,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Story",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "@Christye77",
            notes: ""
        ),

        CustomerData(
            name: "Sukhdeep Jammu",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Suman",
            serviceDay: "Tuesday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "@Suman-Guha",
            notes: ""
        ),

        CustomerData(
            name: "Summer",
            serviceDay: "Tuesday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "@Mario-Jimenez-78",
            notes: ""
        ),

        CustomerData(
            name: "Tiffany Baker",
            serviceDay: "Tuesday",
            monthlyPrice: 165,
            outstandingBalance: 0,
            paymentHandle: "@Tiffany-Baker-10",
            notes: ""
        ),

        CustomerData(
            name: "Tina Smith",
            serviceDay: "Thursday",
            monthlyPrice: 165,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Tolman",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 320,
            paymentHandle: "@Dragon20",
            notes: ""
        ),

        CustomerData(
            name: "Upchurch",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Vergara Saavedra",
            serviceDay: "Tuesday",
            monthlyPrice: 195,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Veronica",
            serviceDay: "Monday",
            monthlyPrice: 185,
            outstandingBalance: 370,
            paymentHandle: "@Alicia-Carrera-1",
            notes: ""
        ),

        CustomerData(
            name: "Vories",
            serviceDay: "Thursday",
            monthlyPrice: 160,
            outstandingBalance: 480,
            paymentHandle: "@Mary-McClelland-3",
            notes: ""
        ),

        CustomerData(
            name: "Wendy",
            serviceDay: "Wednesday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Witt",
            serviceDay: "Wednesday",
            monthlyPrice: 160,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: "x"
        ),

        CustomerData(
            name: "Zara Basel",
            serviceDay: "Tuesday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Yesica",
            serviceDay: "Thursday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Yolanda",
            serviceDay: "Tuesday",
            monthlyPrice: 160,
            outstandingBalance: 360,
            paymentHandle: "",
            notes: "Filter repair 7/28"
        ),

        CustomerData(
            name: "Younen",
            serviceDay: "Monday",
            monthlyPrice: 170,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Douglas Beck",
            serviceDay: "Monday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Carol Davis",
            serviceDay: "Thursday",
            monthlyPrice: 185,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Remon-aguib",
            serviceDay: "Thursday",
            monthlyPrice: 165,
            outstandingBalance: 330,
            paymentHandle: "@remon-aguib",
            notes: ""
        ),

        CustomerData(
            name: "Michael Osgood",
            serviceDay: "Thursday",
            monthlyPrice: 145,
            outstandingBalance: 0,
            paymentHandle: "@Michael-Osgood-1949",
            notes: ""
        ),

        CustomerData(
            name: "Paul Nilo Rd (SAFFRON VILLA INC)",
            serviceDay: "Thursday",
            monthlyPrice: 180,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        ),

        CustomerData(
            name: "Phil Lange",
            serviceDay: "Wednesday",
            monthlyPrice: 500,
            outstandingBalance: 0,
            paymentHandle: "",
            notes: ""
        )
    ]
}//
//  CustomerImporter.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/5/26.
//

