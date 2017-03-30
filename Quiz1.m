x = linspace(-10, 10, 200) 'take 200 points from -10 to 10 on the x-axis'
y = 1./(1+exp(-x)) 'subtitute x into Sigmoid function to get y'
plot(x,y) 'draw graphics by using x,y'
