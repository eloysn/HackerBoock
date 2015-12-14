# HackerBoock

## Respuestas

Ten en cuenta que dicho método devuelve un id que puede contener tanto un NSArray de NSDictionaries como un NSDictionary . Mira en la ayuda en método isKindOfClass: y como usarlo para saber qué te han devuelto exactamente.¿En que otros modos podemos trabajar?¿is, as?

isKindOfClass verifica si es la misma o cualqueir clase que hereda de la misma.  
Con is comprobamos de que clase es un objeto.
Con as podemos convertir objetos a otras clases,hay tres tipos, implicita !as,(downcast forzado, por cojones!!!), la condicional as? por que no sabemos si se hara la conversion(recomendada) y as conversion hacia arriba (upcasting), donde el sistema sabe que no dara errror.

¿Donde Guardar los datos, el Json ,las imagenes y los pdf?
El Json he optado por guardarlo en la carpeta Documents, ya que es un archivo pequeño,para lo demas he optado por la carpeta Caches, si el sistema los elimina podemos descargarlos de nuevo y no tenemos por que sincronizar esos datos con Itunes

El ser o no favorito se indicará mediante una propiedad booleana de AGTBook
( isFavorite ) y esto se debe de guardar en el sistema de ficheros y recuperar de alguna forma. Es decir, esa información debe de persistir de alguna manera cuando se cierra la App y cuando se abre.
¿Cómo harías eso? ¿Se te ocurre más de una forma de hacerlo? Explica la decisión de diseño que hayas toma
Lo he guardado en NSDefault,por que puedo recuperarlo como un objeto, en este caso una propiedad boleana.He optado por que el controlador sea el responsable de guardarlo.

Cuando cambia el valor de la propiedad isFavorite de un AGTBook, la tabla deberá reflejar ese hecho. ¿Cómo lo harías? Es decir, ¿cómo enviarías información de un AGTBook a un AGTLibraryTableViewController? ¿Se te ocurre más de una forma de hacerlo? ¿Cual te parece mejor? Explica tu elección.
Lo he hecho implementando un protocolo.Aunque tambien se podria haber hecho con notificaciones,incluso con clousures, que en este caso las he utilizado para persistir los datos del modelo.

Nota: para que la tabla se actualice, usa el método reloadData de UITableView . Esto hace que la tabla vuelva a pedir datos a su dataSource. ¿Es esto una aberración desde el punto de rendimiento (volver a cargar datos que en su mayoría ya estaban correctos)? Explica por qué no es así. ¿Hay una forma alternativa? ¿Cuando crees que vale la pena usarlo
Yo creo que no es una aberracion, por que en definitiva la tabla solo carga los datos de las vistas que estan visibles para el usuario.

##Notas
La app funciona, se descarga el Json lo guarda y procesa los datos, para una vez descargados, los cargemos desde local,pero me ha faltado ampliar la clase Libary para poder cargar las diferentes secciones de la tabla.
Esto ultimo la verdad no he sabido como cuadrarlo.
