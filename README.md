# Docker ARMHF AirPlay for Raspberry PI

## How to start
	docker run -d --name airplay -v /dev/snd:/dev/snd:rw --net=host --privileged --restart always dweidenfeld/armhf-airplay
