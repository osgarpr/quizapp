//
//  QuizModel.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 8/30/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    func questionRetreive(_ questions:[Question])
}

class QuizModel {
    
    var delegate:QuizProtocol?
    func getQuestions() {
        
        //Fetch the question
        getLocalJasonFile()
        
    }
    
    func getLocalJasonFile() {
        
        //Get bundle path to Json file
        let path = Bundle.main.path(forResource: "questinoData.jason", ofType: "json")//the resourse have to match the jason file name
        
        //Double check that the path is not nil
        guard path != nil else{
            print("Json file not found")
            return
        }
        
        //Create an URL objedt from Path
        let url = URL(fileURLWithPath: path!)
        
        do{
            //Get the data from the url
            let data = try Data(contentsOf: url)
            
            //Try to decode the data into objects
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            //Notify the delegates of the parse object
            delegate?.questionRetreive(array)
        }
        
        catch {
            //Error: Couldnt download the data from the url
            
        }
    }
    
    func getRemoteJasonFile(){
        
    }
    
}

