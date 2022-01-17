//
//  XMLSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.
//

import SwiftUI
import XMLCoder

let sourceXML = """
<scheduledepisode>
 <episodeid>1862297</episodeid>
 <title>Nyheter från Ekot</title>
 <description>Senaste nytt varje timme från Ekoredaktionen.</description>
 <starttimeutc>2022-01-16T23:00:00Z</starttimeutc>
 <endtimeutc>2022-01-16T23:02:00Z</endtimeutc>
 <program id="5380" name="Nyhetsuppdatering från Ekot"/>
 <channel id="132" name="P1"/>
 <imageurl>https://static-cdn.sr.se/images/5380/bd64d128-9787-4a22-8a62-d7e83abbbb6e.jpg?preset=api-default-square</imageurl>
 <imageurltemplate>https://static-cdn.sr.se/images/5380/bd64d128-9787-4a22-8a62-d7e83abbbb6e.jpg</imageurltemplate>
 </scheduledepisode>
"""

struct Note: Codable {
    let episodeid: String
    let title: String
    let description: String
    let starttimeutc : String
}

let formatter1 = DateFormatter()

struct XMLSwiftUIView: View {
    
    let note = try! XMLDecoder().decode(Note.self, from: Data(sourceXML.utf8))
   
    
    
    var body: some View {
        VStack{
        Text(note.episodeid)
        Text(note.title)
        Text(note.description)
        Text(note.starttimeutc)
        }
    }
}
    
struct XMLSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        XMLSwiftUIView()
    }
}


/*
 <scheduledepisode>
 <episodeid>1862297</episodeid>
 <title>Nyheter från Ekot</title>
 <description>Senaste nytt varje timme från Ekoredaktionen.</description>
 <starttimeutc>2022-01-16T23:00:00Z</starttimeutc>
 <endtimeutc>2022-01-16T23:02:00Z</endtimeutc>
 <program id="5380" name="Nyhetsuppdatering från Ekot"/>
 <channel id="132" name="P1"/>
 <imageurl>https://static-cdn.sr.se/images/5380/bd64d128-9787-4a22-8a62-d7e83abbbb6e.jpg?preset=api-default-square</imageurl>
 <imageurltemplate>https://static-cdn.sr.se/images/5380/bd64d128-9787-4a22-8a62-d7e83abbbb6e.jpg</imageurltemplate>
 </scheduledepisode>
 
 */
