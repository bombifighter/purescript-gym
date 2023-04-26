# Edzőterem működését támogató szoftver PureScript és Vue.js alapokon

## Debreceni Egyetem, Informatikai Kar, 2023

Szerzők:
  * Mezei Botond
    * Email: botond20@gmail.com
  * Szabó Benedek
    * Email: szabobenedek99@gmail.com

Témavezető:
  * Dr. Battyányi Péter
    * Email: battyanyi.peter@inf.unideb.hu

## Absztrakt

A PureScript programozási nyelv egy fiatal programozási nyelv melyet Phil Freeman tervezett. Célja egy jobb alternatíva adása a Haskellt JavaScriptre fordító prgramoknak. A szintaxisának köszönhetően tömör, rövid kódok írására van lehetőség és erősebb, modernebb mint más funkcionális nyelvek, például a Haskell. Dolgozatunkban azt szeretnénk megvizsgálni, hogy mennyire alkalmas alkalmazásfejlesztésre a nyelv. A vizsgálat céljából egy REST API implementációt készítettünk.

Alkalmazásunk témájának az edzőtermek világát választottuk. Az alkalmazásban a backendet a PureScript REST API szolgáltatja, míg frontendnek a szintén fiatal, de még gyorsabban fejlődő Vue.js-t JavaScript keretrendszert választottuk.

Ahhoz, hogy a PureScript esetében legyen viszonyítási alapunk egy másik nyelven írt, az elsővel megegyező funkcionalitású REST API-t készítettünk. Ennek alapjául a Java Spring Boot keretrendszerét választottuk. Így teljesebb képet kapunk a PureScript implementációnk helyzetéről.

Dolgozatunkban tehát nem egy üzleti igényeket kielégítő edzőtermi szoftver készítését mutatjuk be, hanem a PureScript nyelv vizsgálatát végezzük el egy REST API implementálásán keresztül.


## A projekt működése

### Függőségek
  * PureScript Backend
    * Node, PureScript, Spago
  * Spring Boot Backend
    * Java 8, Maven
  * Vue.js Frontend
    * Node, Vue

### Futtatás
  * PureScript Backend
    * `spago install` majd `spago run`, a szerver alapértelmezetten a 3000-es porton fog futni.
  * Spring Boot Backend
    * `mvn install spring-boot:run` , a szerver alapértelmezetten a 3000-es porton fog futni.
  * Vue.js Frontend
    * `npm install` majd `npm run dev`, a szerver alapértelmezetten az 5173-as porton fog futni.