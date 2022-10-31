//
//  MainFavoritesView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-31.
//

import SwiftUI

struct Person: Codable {
    //var name: String
    var mytest : [String]
}



struct MainFavoritesView: View {
    
    @ObservedObject var userSettings = UserSettings()
    @State var showingStar = false
    
    //let taylor = Person(name: "Taylor Swift")
    let taylor = Person(mytest: ["p1", "p2"])
    // User default for favorites
    let defaults = UserDefaults.standard
    
    
    var body: some View {
        VStack{
        Text("Favorite")
        Text(userSettings.favorite.description)
            
            Button {
                print("Save Data")
                print(checkIsFavorite(myRadioFavo: "p1"))
                
            } label: {
                Image(systemName: "paperplane")
            }
            .padding()
            
            Button {
               viewData()
            } label: {
                Image(systemName: "doc" )
            }
            
            Button {
                showingStar.toggle()
                if showingStar {
                    //print(showingStar)
                    saveNewData()
                    
                } else {
                    //print(showingStar)
                    deleteNewData()
                }
                
            } label: {
                
                if showingStar {
                   Image(systemName: "star.fill" )
                        .foregroundColor(.newSecundaryColor)
                } else if checkIsFavorite(myRadioFavo: "p1") {
                   
                    Image(systemName: "star.fill" )
                         .foregroundColor(.newSecundaryColor)
                    
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.newSecundaryColor)
                }
            }
            
            
        }
    }
    
    func saveData(myData: Person) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(myData) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedPerson")
        }
    }
    
    func saveNewData() {
        
    
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print("loadedPerson.name")
                //print(loadedPerson.name)
                print(loadedPerson.mytest)
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == "p1"}) {
                   // it exists, do something
                   print("element exists")
                    
                 return
                    
                } else {
                   //item could not be found
                    let moreData = "p1"
                    loadedPerson.mytest.append(moreData)
                    print("saveNewData()")
                    print(loadedPerson.mytest)
                    saveData(myData: loadedPerson)
                    print("new element added")
                }
            }
        } else { print("no data")}
        
    }
    
    func deleteNewData() {
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print("loadedPerson.name")
                //print(loadedPerson.name)
                print(loadedPerson.mytest)
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == "p1"}) {
                   // it exists, do something
                 print("P1 exists")
                 let myIndex = loadedPerson.mytest.firstIndex(of: "p1")
                    print(myIndex!)
                 
                    loadedPerson.mytest.remove(at: myIndex!)
                    
                } else {
                   //item could not be found
                    print("elemento no existe")
                }
                
                print("deleteNewData()")
                print(loadedPerson.mytest)
                
                saveData(myData: loadedPerson)
                
            }
        } else { print("no data")}
    }
    
    
    func checkIsFavorite(myRadioFavo:String) ->Bool {
        
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print("loadedPerson.name")
                print(loadedPerson.mytest)
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == myRadioFavo}) {
                   // it exists, do something
                 //print("Radio \(myRadioFavo) is Favorite")
                 
                return true
                    
                } else {
                   //item could not be found
                    //print("Radio \(myRadioFavo) is not Favorite")
                    
                    return false
                }
            }
        }
        return false
    }
    
    func viewData() {
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print("loadedPerson.name")
                //print(loadedPerson.name)
                print(loadedPerson.mytest)
            }
        }
    }
    
}

struct MainFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        MainFavoritesView()
    }
}
