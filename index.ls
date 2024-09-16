decode = require "image-decode"
require! fs
require! "chroma"
args = process.argv.slice 2
twidth = process.stdout.rows
{data,width} = decode fs.readFileSync __dirname+"/kogasa.png"
rgbaArr = for i from 0 to data.length / 4 then ( for i2 from 0 to 3 then data[ i * 4 + i2 ] )
imgchars = []
chars = []
chars.push chroma.magenta( "TataraKogasa" ).split("") ++ chroma.red("@Gensokyo : ").split ""
for key, rgba of rgbaArr
   if key % width is 0
      imgchars.push []
   imgchars[imgchars.length - 1].push ( if rgba.3 isnt 0 then chroma.apply( @, rgba.slice( 0, -1 )) "#" #█备用
      else " " )
imgchars = imgchars.slice 0, -1
for key, char of args.join " "
   if key % twidth is 0
      chars.push []
      chars[chars.length - 1].push char
   else if char is "\n"
      chars.push []
   else
      chars[chars.length - 1].push char
if imgchars.length >= chars.length
   for key, line of imgchars
      console.log line.join("") + " #{key.padStart 2, "0"}| " + chroma.white( ( chars[key] or [] ).join(""))
else
   for key, line of chars
      console.log line.join("") + " #{key.padStart 2, "0"}| " + chroma.white( ( imgchars[key] or [] ).join(""))