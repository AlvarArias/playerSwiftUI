//
//  MainFavoritesView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-31.
//

import SwiftUI

struct Person: Codable {
    var mytest : [String]
}



struct MainFavoritesView: View {
    
    
    @State var showingStar = false

    // User default for favorites
    let defaults = UserDefaults.standard
    
    //var myData : Person
    
    
    var body: some View {
        VStack{
        Text("Favorite")
        
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
    
                    saveNewData()
                    
                } else {
                  
                    deleteNewData()
                }
                
            } label: {
                
                if showingStar {
                   Image(systemName: "star.fill" )
                        .foregroundColor(.newSecundaryColor)
                } else if checkIsFavorite(myRadioFavo: "p4") {
                   
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
                //print("loadedPerson.name")
                //print(loadedPerson.name)
                print(loadedPerson.mytest)
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == "p4"}) {
                   // it exists, do something
                   print("element exists")
                    
                 return
                    
                } else {
                   //item could not be found
                    let moreData = "p4"
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
                if loadedPerson.mytest.contains(where: {$0 == "p4"}) {
                   // it exists, do something
                 print("P1 exists")
                 let myIndex = loadedPerson.mytest.firstIndex(of: "p4")
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
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
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
