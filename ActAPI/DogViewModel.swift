//
//  DogViewModel.swift
//  ActAPI
//
//  Created by Fernanda.M Guzman on 19/11/23.
//

import Foundation

class DogViewModel : ObservableObject {
    @Published var dog: Dog
    
    init(){
        self.dog = Dog(message: "" , status: "")
    }
    
    func getDogWithoutDecoder(){
   
        let urlRequest = configUrlRequest()
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                print("Error: " + error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Error: Incapaz de conectar o recibir respuesta del servidor")
                return
            }
            
            
            if response.statusCode == 200 {
                
                guard let data = data else {
                    print("Respuesta vacía")
                    return
                }
                
                /*Nuestra lógica de obtención, códificación y asignación de datos
                 dentro de un Dispatch y do Catch
                 */
                DispatchQueue.main.async {
                    do {
   
                        let json  = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                        let jsonData  = json as! NSDictionary
                        
                        let message = jsonData["message"] as? String ?? ""
                        let status = jsonData["status"] as? String ?? ""
                        //NSDictionary para tratarlo Json Object
                        //NSArray para tratarlo como Json Array
                        
                        self.dog = Dog(message: message, status: status)
                        
                    } catch let error {
                        print("Error al decodificar JSON \(error)")
                        return
                    }
                }
               
            }else{
                print("Status diferente a 200. Ejemplos: 500 - Internal server error, 400 - Not found , etc.")
                return
            }
            
        })
        task.resume()
    }
    
    private func configUrlRequest() -> URLRequest{
        let endPoint : String = "https://dog.ceo/api/breeds/image/random"
        
        guard let apiURL = URL(string: endPoint) else{
            fatalError("Url no válida o no definida")
        }
        
        var urlRequest = URLRequest(url: apiURL)
    
       /*Configuración de Cabeceras(Headers) en caso que la petición lo demande:
        urlRequest.addValue("token123", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("ios", forHTTPHeaderField: "User-Agent")
        */
        
        //Especificar tipo de contenido: XML, JSON, String,etc.
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Mencionar tipo de método GET, POST, PUT, PATCH, DELETE
        urlRequest.httpMethod = "GET"
    
        /*Ejemplo de inicialización y envío parametros POST
        let parameters: [String: Any] = [
            "id_trainer" : 1,
            "name" : "Ash",
            "champion" : true,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        urlRequest.httpBody = jsonData
        */

        return urlRequest
    }
    
    func getRandomDog(){
   
        let urlRequest = configUrlRequest()
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                print("Error: " + error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Error: Incapaz de conectar o recibir respuesta del servidor")
                return
            }
            
            
            if response.statusCode == 200 {
                
                guard let data = data else {
                    print("Respuesta vacía")
                    return
                }
                
                /*Nuestra lógica de obtención, códificación y asignación de datos
                 dentro de un Dispatch y do Catch
                 */
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(Dog.self, from: data)
                        /* Sí decodificamos un Json Object sería como este ejmplo pero si fuera un JSON Array sería [Pokemon].self
                        let decoded = try JSONDecoder().decode( MODELO_OBJECT .self, from: data)
                        let decoded = try JSONDecoder().decode( [MODELO_ARRAY] .self, from: data)
                        */
                        self.dog = decoded
                        
                    } catch let error {
                        print("Error al decodificar JSON \(error)")
                        return
                    }
                }
               
            }else{
                print("Status diferente a 200. Ejemplos: 500 - Internal server error, 400 - Not found , etc.")
                return
            }
            
        })
        task.resume()
    }
    
    
}
