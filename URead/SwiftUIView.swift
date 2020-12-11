//
//  SwiftUIView.swift
//  URead
//
//  Created by 万亦然 on 2020/12/11.
//

import SwiftUI

struct SwiftUIView: View {
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.25882354378700256, green: 0.6196078658103943, blue: 0.615686297416687, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing:8){
                //Ellipse 2
                Ellipse()
                    .fill(Color(#colorLiteral(red: 0.9764705896377563, green: 0.9764705896377563, blue: 0.9764705896377563, alpha: 0.9399999976158142)))
                    .frame(width: 790, height: 933, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).ignoresSafeArea().padding(.top, 650)
            }
            LoginUI()
        }
        
        TabView(selection: .constant(1)) {
            
            NavigationView{
                HomeUI().navigationTitle("Book Store")
            }.tabItem {
                Image("home-icon")
            }
            
            
            Text("My Bookshelf")
                .tabItem {
                    Text("My Books")
                    
                }
            
            
            Text("Profile")
                .tabItem {
                    Image("profile-Icon")
                    
                }
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}




