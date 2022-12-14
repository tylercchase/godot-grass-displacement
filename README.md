# Godot Grass Displacement System
A Godot project (Godot version 4 beta 6) that uses the idea of a general texture map for the world centered around a player to keep track of objects. The texture passes information to shaders that need to know how to displace based on those objects.

## Texture
The texture uses the red and green channels to say how much / where the grass should displace. The blue channel acts as a flattening mask where 1 is completely flat to the ground.

![Close-up of texture with green background and circles with varying colors](https://user-images.githubusercontent.com/17506744/206885946-d55e5b8c-bc2a-49d5-a30b-912524776a1c.png)

### In Action
The texture gets remade every frame and updated with the most recent position of tracked objects to write to the texture.
![Player with spheres around them with displaced grass underneath](https://user-images.githubusercontent.com/17506744/206886011-b89ab72c-669b-419b-bd7e-53ece14615af.png)

## Displace Buffer Script
### Area3D
Objects are tracked via an Area3D that follows the player. There is a signal attached listening for when bodies enter the area. When triggered the player script sends the reference of the object off to the displacement buffer singleton. It also sends removes the object from the buffer when it leaves the area.

### Singleton
Constantly updates the texture and lets other resources grab the texture to update their material (this would pipe into a global shader, but sampler2D global shaders are broken). Draws a circle for each object it sees, this could probably be improved in the future to include shapes other than circles.

### Trail
The singleton keeps track of the most recent positions that a player has been, and then writes them to the texture based on their relative position. As time progresses a value attached to each saved location decreases and when that value reaches zero the position is removed from the list.

![Gif of player moving and leaving trail](https://user-images.githubusercontent.com/17506744/206886056-d6659939-3a0d-4e38-a1d4-e88d717addfe.gif)

## Grass
The grass is a particle system with a triangle mesh for the grass blades. The displacement texture modifies the top vertex.
```
VERTEX.x -= (INSTANCE_CUSTOM.r * 2.0 - 1.0) * VERTEX.y * 0.2;
VERTEX.z -= (INSTANCE_CUSTOM.g * 2.0 - 1.0) * VERTEX.y * 0.2;
```

# References
 - [Player Interactions Visualized (Hitman)](https://youtu.be/0x_lIq3FEQE)
 - [Procedural Grass in 'Ghost of Tshuma'](https://youtu.be/Ibe1JBF5i5Y)
 - [Interactive Wind and Vegetation in 'God of War'](https://youtu.be/MKX45_riWQA)
 - [BOTW style grass](https://youtu.be/usdwhhZWIJ4)
 - [Godot Grass Shader Tutorial](https://youtu.be/uMB3-g8v1B0)