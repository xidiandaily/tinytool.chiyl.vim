all:
	python --version

timestamp:
	rm -rf ./dist
	rm -rf ./build
	pyinstaller --onefile  ./timestamp_to_utc8.py 2>&1 |tee pack.log
	mv dist/timestamp_to_utc8.exe ../exe/

run:
	python timestamp_to_utc8.py -i G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.in.timestamp_to_utc8 -o G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.out.timestamp_to_utc8

clean:
	rm -rf ./dist
	rm -rf ./build

