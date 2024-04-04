run:
	love src/

love:
	mkdir -p dist
	cd src && zip -r ../dist/3x3-2D-transformations.love .

js: love
	love.js -c --title="2D transformations demo with 3x3 matrices" ./dist/3x3-2D-transformations.love ./dist/js
