//
//  ContentView.swift
//  ActAPI
//
//  Created by Fernanda.M Guzman on 19/11/23.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var randomDog : DogViewModel
    @State var imageURL = "https://pngfre.com/wp-content/uploads/1653590437470-661x1024.png"
    @State var isHappy: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("API DOG")
                .frame(width: .infinity)
                .font(.title)
                .foregroundColor(Color.blue)
                .bold()
                .multilineTextAlignment(.center)
            
            AsyncImage(url: URL(string: imageURL)){
                estadoDeImagen in
                
                switch estadoDeImagen {
                case .empty:
                  
                    ProgressView()
                    
                case .success(let image) :
                    
                    image
                        .resizable()
                        .frame(width: .infinity , height: isHappy ? 500 : 300 )
                    
                case .failure:
                    
                    Image(systemName: "face")
                        .resizable()
                        .frame(width: .infinity , height: 350 )
                    
                default:
                    EmptyView()
                }
            }
            Spacer()
            Button(action: {
                self.isHappy = true
                randomDog.getRandomDog()
                self.imageURL = randomDog.dog.message
            }){
                Text("SHOW")
                    .font(.title)
                    .bold()
                    .padding([.leading, .trailing], 30)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(12)
                    .padding(.top, 30)
            }
        }
        .padding()
        .background(Color("white"))
        .frame(width: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DogViewModel())
    }
}
