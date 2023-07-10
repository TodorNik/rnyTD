# rnyTD
A tower defense game made using love2d
My first non-tutorial project in love2D
<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->

<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![MIT License][license-shield]][license-url]

<!-- ABOUT THE PROJECT -->

## About This Repo

A tower defense game made in LOVE. The game features three levels with three waves of enemies. Posssesses three tower options which simply escalate in strength currently. The visuals are done with the built-in graphic functions.

I've coded the whole game aside from the pathfinding library, Jumper. Jumper is a pathfinding library by Yonaba, the original source code can be found here (https://github.com/Yonaba/Jumper).

Sound file pop.ogg was provided by Mixkit library of sound effects (https://mixkit.co/free-sound-effects/pop/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

- [![Lua][Lua-shield]][Lua-url]
- [![LÖVE][LOVE-shield]][LOVE-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

### Files

Aside from the jumper and classic library, the following files were written by me:

1. main.lua: Main file for the game
2. enemy.lua: Information and functions of the enemy entity
3. player.lua: Information and functions of the player entity
4. conf.lua: Configuration files for the game

### Prerequisites
- Lua

- LÖVE

### Installation

A. Only LÖVE required 
  1. Download Rny_Tower_Defense.love
  2. Double-click the file
  3. Play

B. Raw code start
  1. Clone the repo
    ```sh
    git clone https://github.com/TodorNik/rnyTD
    ```
  2. cd into a chapter or game directory
    ```sh
    cd rnyTD/
    ```
  3. Run main.lua using LÖVE
     ```sh
     love . or lovec .
     ```
  4. Play

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

- [] Add abilities to towers
- [] Visual update to the whole game (color scheme takes precedence)
- [] Create more levels
- [] Add boss stages at the end of each level
- [] Animate enemies and fix a few enemy overlaps

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/wem1c/Learn-To-LOVE/blob/master/LICENSE
[Lua-shield]: https://img.shields.io/badge/Lua-5B1B1B?style=for-the-badge&logo=lua&logoColor=white
[Lua-url]: https://www.lua.org/
[LOVE-shield]: https://img.shields.io/badge/LÖVE-5B1B1B?style=for-the-badge&logo=love&logoColor
[LOVE-url]: https://www.love.com/

