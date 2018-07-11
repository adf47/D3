require 'sinatra'
require 'sinatra/reloader'
GlobalState = {}

# Determine fibonacci number
def fibonacci(n)
  return  n  if ( 0..1 ).include? n
  return (fibonacci( n - 1 ) + fibonacci( n - 2 ))
end

# Determine factorial number
def factorial(n)
  if n == 0
    1
  else
    n * factorial(n-1)
  end
end

def calulate_name(name)
    return name.upcase
end

# If a GET request comes in at /, do the following.

get '/' do
  # Get the parameter named guess and store it in pg
  fib = params['Fibonacci']
  fac = params['Factorial']
  hi = params['Say hello']
  
  # Array of all possible HTML color names
  color_names = ["AliceBlue","AntiqueWhite","Aqua","Aquamarine","Azure","Beige","Bisque","Black","BlanchedAlmond","Blue","BlueViolet","Brown","BurlyWood","CadetBlue","Chartreuse","Chocolate","Coral","CornflowerBlue","Cornsilk","Crimson","Cyan","DarkBlue","DarkCyan","DarkGoldenRod","DarkGray","DarkGrey","DarkGreen","DarkKhaki","DarkMagenta","DarkOliveGreen","Darkorange","DarkOrchid","DarkRed","DarkSalmon","DarkSeaGreen","DarkSlateBlue","DarkSlateGray","DarkSlateGrey","DarkTurquoise","DarkViolet","DeepPink","DeepSkyBlue","DimGray","DimGrey","DodgerBlue","FireBrick","FloralWhite","ForestGreen","Fuchsia","Gainsboro","GhostWhite","Gold","GoldenRod","Gray","Grey","Green","GreenYellow","HoneyDew","HotPink","IndianRed","Indigo","Ivory","Khaki","Lavender","LavenderBlush","LawnGreen","LemonChiffon","LightBlue","LightCoral","LightCyan","LightGoldenRodYellow","LightGray","LightGrey","LightGreen","LightPink","LightSalmon","LightSeaGreen","LightSkyBlue","LightSlateGray","LightSlateGrey","LightSteelBlue","LightYellow","Lime","LimeGreen","Linen","Magenta","Maroon","MediumAquaMarine","MediumBlue","MediumOrchid","MediumPurple","MediumSeaGreen","MediumSlateBlue","MediumSpringGreen","MediumTurquoise","MediumVioletRed","MidnightBlue","MintCream","MistyRose","Moccasin","NavajoWhite","Navy","OldLace","Olive","OliveDrab","Orange","OrangeRed","Orchid","PaleGoldenRod","PaleGreen","PaleTurquoise","PaleVioletRed","PapayaWhip","PeachPuff","Peru","Pink","Plum","PowderBlue","Purple","Red","RosyBrown","RoyalBlue","SaddleBrown","Salmon","SandyBrown","SeaGreen","SeaShell","Sienna","Silver","SkyBlue","SlateBlue","SlateGray","SlateGrey","Snow","SpringGreen","SteelBlue","Tan","Teal","Thistle","Tomato","Turquoise","Violet","Wheat","White","WhiteSmoke","Yellow","YellowGreen"]
  
  # Check for parameter to persist color across refreshes and backreferences
  unless params.has_key?(:Color)
    new_color = GlobalState[:new_color]
  else
    new_color = params['Color']
  end
  
  # Set to default if not in HTML color array
  unless color_names.include? new_color
    new_color = 'LightBlue'
  end
  GlobalState[:new_color] = new_color
  
  
  erb :index, :locals => { fibonacci: fib, factorial: fac, say_hi: hi }
end

get '/fibonacci' do
  # Display the fib number here
  fib = params['Fibonacci']

  if fib.to_i < 0 || (fib.to_i.to_s != fib)
      fib = 1
  end
  
  fib_calc = fibonacci(fib.to_i)

  erb :fibonacci, :locals => { fibonacci: fib, fibonacci_calculated: fib_calc}
end

get '/factorial' do
  # Display the fac number here
  fac = params['Factorial']
  if fac.to_i < 0 || (fac.to_i.to_s != fac)
      fac = 1
  end
  fac_calc = factorial(fac.to_i)

  erb :factorial, :locals => { factorial: fac, factorial_calulated: fac_calc}
end

get '/sayhi' do
  # Display the fac number here
  name = params['Say hello']
  uppercase_name = calulate_name(name)

  erb :say_hi, :locals => { name: uppercase_name }
end

get '/showcat' do 
  cat_color = params['Cat color'].downcase
  #seed = params['Seed']
  ##seed = 3
  ##prng = Random.new(seed)
  num = rand 1..3
  
  erb :show_cat, :locals => { color: cat_color, num: num }
end

not_found do
  status 404
  erb :error
end

