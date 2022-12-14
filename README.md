# Godot Grass Displacement System
A Godot project that uses the idea of a general texture map for the world centered around a player. The texture shows how the grass should be at each location relative to the player.

## Texture
The texture uses the red and green channels to say how much/ where the grass should displace and the blue channel to act as a flattening mask where 1 is completely flat to the ground.

![Close up of texture with green background and circles with varying colors](https://user-images.githubusercontent.com/17506744/206885946-d55e5b8c-bc2a-49d5-a30b-912524776a1c.png)

### In Action
The texture gets remade every frame and updated with the most recent position of tracked objects to write to the texture.
![Player with spheres around them with displaced grass underneath](https://user-images.githubusercontent.com/17506744/206886011-b89ab72c-669b-419b-bd7e-53ece14615af.png)

## Displace Buffer Script
### Area3D
Objects are tracked via an Area3D that has a signal for when bodys enter the area. When this happens the player script sends the reference to the object off

### Singleton
Constantly updates the texture and lets other resources grab the texture to update their material (this would pipe into a global shader, but sampler2D global shaders are broken)
### Trail
The singleton keeps track of the most recent positions that a player has been and then writes there as well. As time progresses a value attached to each instance of the player moving decreases and when that value reaches zero the position is removed from the list.

![Gif of player moving and leaving trail](https://user-images.githubusercontent.com/17506744/206886056-d6659939-3a0d-4e38-a1d4-e88d717addfe.gif)

## Grass
The grass is a particle system with a triangle mesh for the grass blades. The displacement texture modifies the top vertex.

# References
 - [Player Interactions Visualized (Hitman)](https://youtu.be/0x_lIq3FEQE)
 - [Procedural Grass in 'Ghost of Tshuma'](https://youtu.be/Ibe1JBF5i5Y)
 - [Interactive Wind and Vegetation in 'God of War'](https://youtu.be/MKX45_riWQA)
 - [BOTW style grass](https://youtu.be/usdwhhZWIJ4)
 - [Godot Grass Shader Tutorial](https://youtu.be/uMB3-g8v1B0)