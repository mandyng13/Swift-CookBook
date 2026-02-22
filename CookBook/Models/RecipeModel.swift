//
//  RecipeModel.swift
//  CookBook
//
//  Created by Mandy Nguyen on 11.02.26.
//

import Foundation

enum Category: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    
    case none = "None"
    case cake = "Cake"
    case cookie = "Cookie"
    case frosting = "Frosting"
}

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

struct Recipe: Identifiable, Codable {
    let id: UUID
    let name: String
    let imageData: Data?
    let difficulty: Difficulty
    let ingredients: String
    let directions: String
    let tips: String?
    let category: Category.RawValue
    let totalTime: Int
}

extension Recipe {
    static let all: [Recipe] = [
        Recipe(
            id: UUID(),
            name: "Matcha Cookies",
            imageData: nil,
            difficulty: .easy,
            ingredients:
                """
                200g Mehl
                20g Matcha
                1 TL Speisestärke
                1/2 TL Backpulver
                1/2 TL Salz
                110g Zucker
                100g Butter (Zimmertemperatur)
                1 Ei + 1 Eigelb
                Weiße Schokolade
                """,
            directions:
                """
                Mische Butter, Ei und Eigelb zusammen
                Sieb die trockenen Zutaten in die flüssige Masse
                Hacke die Schokolade klein und gib sie in die Masse hinzu
                Forme den Teig in Kugeln
                Bei 180°C für 10-15 Minuten backen
                """,
            tips: nil,
            category: "Cookie",
            totalTime: 45
        ),
        Recipe(
            id: UUID(),
            name: "Vanilla Chiffon Cake",
            imageData: nil,
            difficulty: .easy,
            ingredients:
                """
                3 (große) Eier (Zimmertemperatur)
                48g Milch
                35g (Sonnenblumen-)Öl
                1/2 TL Vanilleextrakt
                40g Mehl (Typ 405)
                8g Speisestärke
                1/2 TL Backpulver
                48g Zucker
                """,
            directions:
                """
                Eigelb und Eiweiß trennen
                Eigelb mit Milch, Öl und Vanillextrakt gut verrühren
                Mehl und Backpulver in die Mischung sieben und unterheben
                Eiweiß aufschlagen und den Zucker nach und nach dazugeben, bis steife Spitzen entstehen
                Den Eischnee vorsichtig unter die Eigelbmasse heben
                Bei 160°C für 25-30 Minuten backen
                """,
            tips:
                """
                zuerst 10 Minuten bei 160°C, danach auf 150°C reduzieren, damit der Kuchen nicht zusammenfällt und gleichmäßig aufgeht
                die Form nicht einfetten, nur den Boden mit Backpapier auslegen -> der Teig kann besser "hochklettern" und wird fluffiger
                nach dem Backen kopfüber auskühlen lassen, damit der Kuchen nicht einsinkt
                """,
            category: "Cake",
            totalTime: 60
        ),
        Recipe(
            id: UUID(),
            name: "Mascarpone Frosting",
            imageData: nil,
            difficulty: .easy,
            ingredients:
                """
                250g Mascarpone (kalt)
                200 ml Schlagsahne (kalt)
                2-3 EL Puderzucker
                1 Päckchen Sahnesteif
                Vanille oder Zitronenabrieb (optional)
                """,
            directions:
                """
                Mascarpone, Puderzucker und Vanille (oder Zietronenabrieb) kurz cremig rühren (nicht aufschlagen!)
                In einer zweiten Schüssel Sahne und Sahnesteif steif schlagen
                Die steifgeschlagene Sahne löffelweise unter die Mascarponemasse heben (mit einem Teigschaber oder Mixer auf niedrigster Stufe)
                """,
            tips: nil,
            category: "Frosting",
            totalTime: 15
        ),
    ]
}
