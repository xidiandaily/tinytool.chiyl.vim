all:
	python --version

timestamp:
	rm -rf ./dist
	rm -rf ./build
	pyinstaller --onefile  ./timestamp_to_utc8.py 2>&1 |tee pack.log
	mv dist/timestamp_to_utc8.exe ../exe/

run:
	python timestamp_to_utc8.py

clean:
	rm -rf ./dist
	rm -rf ./build

