import CoreData  // Importamos CoreData para manejar la base de datos local
//
//  StoreDataProvider.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 9/4/25.
//
import Foundation  // Importamos Foundation para funcionalidades básicas de Swift

class StoreDataProvider {  // Clase que se encarga de configurar y manejar todo el stack de Core Data

    let persistentContainer: NSPersistentContainer  // Contenedor que agrupa el modelo, coordinador y contexto de Core Data

    var context: NSManagedObjectContext {  // Propiedad para acceder fácilmente al contexto principal
        var viewContext = self.persistentContainer.viewContext
        return viewContext
    }
    // singleton el constructor es privado
    private init() {  // Inicializador del StoreDataProvider
        self.persistentContainer = NSPersistentContainer(name: "Model")  // Creamos el contenedor con el nombre del modelo .xcdatamodeld

        self.persistentContainer.loadPersistentStores { description, error in  // Cargamos el almacenamiento persistente
            if let error = error as NSError? {
                fatalError("CoreData couldn't load BBDD from Model")  // Si falla la carga, detenemos la app (en producción se debería manejar mejor)
            }
        }
    }
    
    func saveContext() {  // Función para guardar los cambios realizados en el contexto
        context.perform {  // Ejecutamos en el hilo correcto para evitar errores de concurrencia
            guard self.context.hasChanges else { return }  // Si no hay cambios pendientes, no hacemos nada
            do {
                try self.context.save()  // Intentamos guardar los cambios en la base de datos
            } catch {
                debugPrint("There was an error saving the context: \(error)")  // Si falla, mostramos el error en la consola para depurar
            }
        }
    }
}

extension StoreDataProvider {
    
    // Método para obtener héroes desde Core Data con un filtro opcional
    func fechtHeroes(filter: NSPredicate?) -> [MOHero] {
        let request = MOHero.fetchRequest()              // Creamos una solicitud (fetchRequest) para la entidad MOHero
        request.predicate = filter                       // Aplicamos el filtro (si lo hay) para hacer búsquedas más específicas
        return try! context.fetch(request)               // Ejecutamos la solicitud y devolvemos los resultados (¡try! lanza excepción si falla!)
    }
    
    // Inserta un array de héroes recibido desde la API en Core Data
    func insert(heroes: [ApiHero]) {
        for hero in heroes {                             // Recorremos cada héroe del array
            let newHero = MOHero(context: context)       // Creamos una nueva instancia de MOHero vinculada al contexto de Core Data
            newHero.identifier = hero.id                 // Asignamos el identificador del héroe desde la API
            newHero.name = hero.name                     // Asignamos el nombre del héroe
            newHero.photo = hero.photo                   // Asignamos la URL o string de la imagen
            newHero.favorite = hero.favorite ?? false    // Si el campo favorite no viene, asumimos que no es favorito
        }
        saveContext()                                    // Guardamos todos los cambios en Core Data
    }
    
    // Inserta un array de localizaciones de héroes recibido desde la API en Core Data
    func insert(location: [ApiHeroLocation]) {
        for location in location {                       // Recorremos cada localización del array
            let newLocation = MOHeroLocation(context: context) // Creamos una nueva instancia de MOHeroLocation en Core Data
            newLocation.identifier = location.id         // Asignamos el identificador de la localización
            newLocation.latitude = location.latitude     // Asignamos la latitud como string
            newLocation.longitude = location.longitude   // Asignamos la longitud como string
            newLocation.date = location.date             // Asignamos la fecha en la que se vio al héroe
            
            if let identifier = location.hero?.id {      // Si la localización tiene asociado un héroe...
                let predicate = NSPredicate(
                    format: "identifier == %@",          // Creamos un filtro para buscar al héroe por ID
                    identifier
                )
                newLocation.hero = fechtHeroes(filter: predicate).first // Obtenemos el primer héroe que coincida y lo asignamos a la localización
            }
        }
        saveContext()                                    // Guardamos todas las nuevas localizaciones en Core Data
    }
}
