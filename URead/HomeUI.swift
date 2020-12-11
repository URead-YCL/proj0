//
//  HomeUI.swift
//  URead
//
//  Created by 万亦然 on 2020/12/11.
//

import SwiftUI

struct HomeUI : View{
    
    @State var searchText = ""
    
    var body : some View{
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
            HStack{
                TextField("Search here", text: $searchText).padding(.leading, 30)
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.5882353186607361, green: 0.8274509906768799, blue: 0.8274509906768799, alpha: 0.1899999976158142))
            .cornerRadius(10)
            .frame(width: 343, height: 36))
            .padding(.horizontal)
            .overlay(
                HStack{
                    Image("icons8-star_filled")
                    Spacer()
                    Text("X")
                }.padding(.horizontal,30)
            )
                         
            VStack{
                ForEach((0..<10).filter({"\($0)".contains(searchText)||searchText.isEmpty}), id: \.self) {_ in
                    
                    HomeBook(image:"", title:"", author:"", summary:"")
                }
            }
        }

    }
}

struct HomeUI_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

struct HomeBook : View{
    var image = ""
    var title = ""
    var author = ""
    var summary = ""
    
    var body : some View{
        
        ZStack{
            //Background with shadow
            Rectangle()
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .frame(width: 362, height: 146)
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
            
            HStack{
                //Book image
                Image("catcher-in-the-rye").resizable().frame(width: 120, height:130, alignment: .leading).clipped()
                
                //Book info
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
                    //The Catcher in the Rye
                    Text("The Catcher in the Rye").font(.custom("Coda Caption ExtraBold", size: 17))
                    
                    //Author & star
                    HStack{
                        //J. D. Salinger
                        Text("J. D. Salinger").font(.custom("Coda Regular", size: 17)).foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.49, blue: 0.49, alpha: 1))).tracking(-0.41)
                        
                        Spacer()
                        //Starred button
                        Button(action: {
                            
                        }) {
                            Image("icons8-star").resizable().frame(width: 24, height: 24)
                        }.padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                    
                    Text("The novel details two days in the life of 16-year-old Holden Caulfield after he has been expelled from prep school ...").frame(width: 230).lineLimit(3)
                }
                
            }
        }.padding(.horizontal)
        
    }
}
