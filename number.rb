require 'sinatra'
require 'sinatra/reloader'

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


not_found do
  status 404
  erb :error
end
