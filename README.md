# YAGBTA

YAGBTA (Yet Another Godot Behavior Tree Addon) es un addon de árboles de comportamiento para Godot. Fue implementado debido a que otros addons existentes no cumplían con ciertos requisitos de los proyectos del equipo para el que trabajo; entre ellos:

- Árboles de comportamiento verdaderamente reactivos, o sea, que la raíz envíe la señal (*tick*) de manera periódica a los hijos, y que el tiempo que tarda el árbol entre una señal y otra sea configurable. Sorprendentemente, la mayoría de los addons que encontré no cumplían con este requisito.
- Una pizarra (blackboard) independiente del funcionamiento básico del árbol (secuencias, selectores, decoradores...) por lo que pueda ser compartida por varios árboles, o incluso eliminada o intercambiada por otra en tiempo de ejecución.
- Diversos nodos estándares del modelo de árboles de comportamiento más allá de los estrictamente imprescindibles, como una rama que permita la ejecución de todos sus hijos en paralelo, o un decorador que ejecute su hijo constantemente hasta que falla.
- Secuencias y selectores más flexibles que permitan, en el mismo nodo y durante el diseño del árbol, decidir si se quiere que sean o no reactivos, o si se quiere que ordene sus hijos de forma aleatoria antes de ejecutarse.

## Uso

Para crear un nuevo árbol de comportamiento, debe añadirse el nodo `BehaviorTreeRoot` a la escena donde se encuentra el actor que hará uso del mismo. Si en el atributo `actor_path` de dicho nodo, visible desde el editor, no se establece una ruta para el actor, se tomará como actor por defecto el padre del nodo. Otros atributos modificables de la raíz del árbol son la pizarra, el cual debe ser un recurso de tipo `Blackboard`, el tiempo entre señales (`tick_time`) y si el árbol está activo desde el comienzo

La raíz del árbol debe tener un solo hijo (normalmente un nodo de tipo `Sequence` o `Selector`), al cual le envía constantemente la señal (*tick*) a intervalos medidos por la variable `tick_time`. Dicho nodo, así como cada uno del resto de los nodos del árbol, reacciona diferente de acuerdo a sus características particulares.  Dos nodos particulares, `BehaviorTreeAction` y `BehaviorTreeCondition ` existen con el único objetivo de servir como base a las acciones y condiciones particulares de cada proyecto, por lo que cada una de las mismas consiste en una escena y un script que hereda de dichas clases y sobrescribe el método `tick()` . A continuación se describen con más detalle cada uno de los nodos implementados, así como el procedimiento para crear acciones y condiciones particulares:

### Lista de nodos

- ![BehaviorTreeNode](icons\BehaviorTreeNode.svg) `BehaviorTreeNode`: Nodo usado como base para crear el resto de los nodos del árbol. No debe ser añadido directamente a la escena ni usado como base para crear otros nodos. Si desean hacérsele cambios, debe modificarse esta clase directamente.
  - ![BehaviorTreeBranchedNode](icons\BehaviorTreeBranchedNode.svg) `BehaviorTreeBranchedNode`: Nodo usado como base para crear otros nodos que tengan hijos (nodos de tipo `Decorator` y `Composite`). No debe ser añadido directamente a la escena ni usado como base para crear otros nodos. Si desean hacérsele cambios, debe modificarse esta clase directamente.
  	- ![BehaviorTreeRoot](icons\BehaviorTreeRoot.svg) `BehaviorTreeRoot`: Nodo raíz del árbol. Debe ser usado como primer nodo en un árbol de comportamiento, y tener solamente un hijo  (normalmente un nodo de tipo `Sequence` o `Selector`), al cual le envía constantemente la señal (*tick*) a intervalos medidos por la variable `tick_time`.  El atributo `actor_path` define el actor que hace uso del árbol, si se deja en blanco se tomará como actor por defecto el padre del nodo. El atributo `blackboard` es la pizarra del árbol, y debe ser un recurso de tipo `Blackboard`, y el atributo `active` define si el árbol está o no enviando señales.
  	- ![BehaviorTreeComposite](icons\BehaviorTreeComposite.svg) `BehaviorTreeComposite`: Nodo usado como base para crear nodos compuestos (con más de un hijo). Puede ser usado como base para crear nodos compuestos más complejos o con funcionamiento diferente a los que ya están implementados. El atributo `reactive` define si cuando recibe un *tick* comienza a procesar desde el primer hijo, o desde el último hijo que devolvió el estado `RUNNING`. El atributo `random` define si cuando comienza a ejecutarse ordena sus hijos de forma aleatoria.
  		- ![BehaviorTreeParalell](icons\BehaviorTreeParallel.svg) `BehaviorTreeParallel`:  Este nodo envía la señal que recibe a todos sus hijos al mismo tiempo, o, en otras palabras, los ejecuta en paralelo. Por ello, los atributos `reactive` y `random` son irrelevantes en este caso.
  		- ![BehaviorTreeSelector](icons\BehaviorTreeSelector.svg) `BehaviorTreeSelector`: Este nodo procesa todos sus hijos desde el comienzo y se detiene (devolviendo `SUCCSESS`) en el momento que alguno devuelve `SUCCESS`. Si algún nodo devuelve `FAILURE`, continúa al siguiente. El comportamiento cuando un hijo devuelve `RUNNING` depende del estado del atributo `reactive`.
  		- ![BehaviorTreeSequence](icons\BehaviorTreeSequence.svg) `BehaviorTreeSequence`:  Este nodo procesa todos sus hijos desde el comienzo y se detiene (devolviendo `FAILURE`) en el momento que alguno devuelve `FAILURE`. Si algún nodo devuelve `SUCCESS`, continúa al siguiente. El comportamiento cuando un hijo devuelve `RUNNING` depende del estado del atributo `reactive`.
  	- ![BehaviorTreeDecorator](icons\BehaviorTreeDecorator.svg) `BehaviorTreeDecorator`: Nodo usado como base para crear decoradores (nodos con solamente un hijo y que modifican el comportamiento del mismo). Puede ser usado como base para crear decoradores más complejos o con funcionamiento diferente a los que ya están implementados.
    	- ![BehaviorTreeSucceeder](icons\BehaviorTreeSucceeder.svg) `BehaviorTreeSucceeder`: Procesa el nodo decorado e, independientemente del resultado, devuelve `SUCCEESS` (si el nodo devuelve `RUNNING`, el decorador también devolverá `RUNNING`).
    	- ![BehaviorTreeFailer](icons\BehaviorTreeFailer.svg) `BehaviorTreeFailer`:Procesa  el nodo decorado e, independientemente del resultado, devuelve `FAILURE` (si el nodo devuelve `RUNNING`, el decorador también devolverá `RUNNING`) .
    	- ![BehaviorTreeInverter](icons\BehaviorTreeInverter.svg) `BehaviorTreeInverter`:Procesa  el nodo decorado y devuelve el resultado contrario (si el nodo devuelve `RUNNING`, el decorador también devolverá `RUNNING`). 
    	- ![BehaviorTreeRepeater](icons\BehaviorTreeRepeater.svg) `BehaviorTreeRepeater`: Procesa el nodo decorado una cantidad de veces definida por el atributo `times`,
    	- ![BehaviorTreeUntilFails](icons\BehaviorTreeUntilFails.svg) `BehaviorTreeUntilFails`: Procesa continuamente el nodo decorado hasta que devuelve `FAILURE`
	- ![BehaviorTreeLeaf](icons\BehaviorTreeLeaf.svg) `BehaviorTreeLeaf`: Hojas del árbol (acciones y condiciones). Puede usarse para crear nuevas acciones y condiciones, ya que esos dos nodos en particular (`BehaviorTreeAction` y `BehaviorTreeCondition`) son clases en blanco que simplemente heredan de esta, pero por una cuestión de claridad y organización se recomienda usar las anteriores.
	  - ![BehaviorTreeAction](icons\BehaviorTreeAction.svg) `BehaviorTreeAction`: Nodo en blanco (hereda directamente de la clase `BehaviorTreeLeaf` sin definir ninguna funcionalidad específica) usado para definir acciones.
	  - ![BehaviorTreeCondition](icons\BehaviorTreeCondition.svg) `BehaviorTreeCondition`: Nodo en blanco (hereda directamente de la clase `BehaviorTreeLeaf` sin definir ninguna funcionalidad específica) usado para definir condiciones.

Como interfaz común existe la pizarra (![Blackboard](icons\Blackboard.svg) `Blackboard`), un recurso (no un nodo), establecido en la raíz pero al cual tienen acceso todos los nodos del árbol. La pizarra posee los métodos `set_data(key, value)` y `get_data(key)` usados para establecer un intercambio de datos entre dichos nodos.

### Creando nuevas acciones y condiciones

Para crear una nueva acción o condición, debe crearse un script (y opcionalmente añadido a una escena) que herede de la clase `BehaviorTreeAction` o `BehaviorTreeCondition`. La diferencia es solo por propósitos de organización del proyecto, ya que ambas clases son idénticas. Dicho script debe sobrescribir el método `tick()`, en el debe necesariamente devolver `SUCCESS`, `FAILURE` o `RUNNING`. Estos nodos tienen acceso al actor conectado al árbol (atributo `actor`) y al nodo raíz del árbol (atributo `tree_root`). A través del mismo, tienen acceso también a la pizarra (`tree_root.blackboard`)

**Ejemplo de acción**:

A continuación se muestra una versión simplificada de una acción que permita a personaje desplazarse a determinada posición. Se sobreentiende que dicho personaje tiene acceso al método `walk_to(position)`.

```gdscript
extends BehaviorTreeAction

export var target_position = Vector3()

func tick():
	if actor.position == target_position:
		return SUCCESS
    
	if tree_root.blackboard.get_data("target_pos") == target_position:
		return RUNNING
    
	blackboard.set_data("target_pos", target_position)
	actor.walk_to(position)
	return RUNNING
```

**Ejemplo de condición**:

A continuación se muestra una condición que identifica si el personaje está en estado de descanso (`IDLE`) :

```gdscript
extends BehaviorTreeCondition

func tick():
	if actor.current_state == actor.IDLE:
		return SUCCESS
	
	return FAILURE
```
