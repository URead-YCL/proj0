//
//  LoginUI.swift
//  URead
//
//  Created by 万亦然 on 2020/12/11.
//

import SwiftUI

struct LoginUI:View{
    
    @State var user = ""
    @State var password = ""
    
    var body: some View{
        
        VStack{
            
            Image("title").resizable().frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Divider()
            
            //Welcome!
            Text("Welcome!").font(.custom("Coda Caption ExtraBold", size: 20)).tracking(-0.3).padding()
            
            //Username
            ZStack {
                Rectangle()
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))

                Rectangle()
                    .strokeBorder(Color(#colorLiteral(red: 0.25882354378700256, green: 0.6196078658103943, blue: 0.615686297416687, alpha: 1)), lineWidth: 2)
                
                TextField("Username", text: $user).padding(.leading, 10)
                
            }
            .frame(width: 343, height: 52).padding(.bottom, 5)
            
            //Password
            ZStack {
                Rectangle()
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))

                Rectangle()
                .strokeBorder(Color(#colorLiteral(red: 0.25882354378700256, green: 0.6196078658103943, blue: 0.615686297416687, alpha: 1)), lineWidth: 2)
                
                TextField("Password", text: $password).padding(.leading, 10)
            }
            .frame(width: 343, height: 52).padding()
            
            //Login & New account
            HStack{
                //Login
                Button(action: {}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))

                        RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), lineWidth: 2)
                        
                        Text("login").foregroundColor(.black).font(.custom("Coda Regular", size: 17)).tracking(0.68).multilineTextAlignment(.center)
                        //Available in iOS 14 only
                        .textCase(.uppercase)
                    }
                    .frame(width: 167, height: 52)
                }
                
                //New Account
                Button(action: {
                    
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .frame(width: 167, height: 52)
                        
                        Text("NEw Account").font(.custom("Coda Regular", size: 17)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(0.68).multilineTextAlignment(.center)
                        //Available in iOS 14 only
                        .textCase(.uppercase)
                    }
                    .frame(width: 167, height: 52)
                }
                
            }
            
            
            
        }.padding(.horizontal, 5)
    }
}


struct LoginUI_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
