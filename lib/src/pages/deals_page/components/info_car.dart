import 'package:car_app/src/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class InfoCarWidget extends StatefulWidget {
  const InfoCarWidget({super.key,
    this.onPressed, 
    this.isFavorite= false, 
    this.car,
  });
  final Function()? onPressed;
  final bool isFavorite;
  final CarModel? car;

  @override
  State<InfoCarWidget> createState() => _InfoCarWidgetState();
}

class _InfoCarWidgetState extends State<InfoCarWidget> {

  int gottenStars=5;

  @override
  Widget build(BuildContext context) {

    Widget buildImage(){
      return CachedNetworkImage(
        imageUrl: widget.car!.image![0],
        progressIndicatorBuilder: (context, url, progress) {
          if(progress.progress!=null){
            final percent = progress.progress! *100;
            return Center(child: Text('$percent% done loading!'));
          }
          return const Column(
            children: [
              Text('Loading....!'),
              SizedBox(height: 5,),
              CircularProgressIndicator(),
            ],
          );
        },
        imageBuilder: (context, imageProvider) => Container(
          height: 150,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children:[
            buildImage(),

            // Positioned(
            //   top: 5,
            //   right: 5,
            //   child: IconButton(
            //     onPressed: (){
            //       widget.onPressed!();
            //     }, 
            //     // icon: widget.listCar!.contains(widget.car) 
            //     // ? const Icon(Icons.favorite, color: Colors.red)
            //     icon: const Icon(Icons.favorite_border, color: Colors.pink,)
            //   ),
            // )
    
          ] 
        ),
        const SizedBox(height: 10,),
        Text(
          widget.car?.name ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => InkWell(
                onTap: (){
                  setState(() {
                    gottenStars=index+1;
                  });
                },
                child: Icon(
                  Icons.star,
                  color: index<gottenStars? Colors.yellow : Colors.grey,
                ),
              )),
            ),
            const SizedBox(width: 5,),
            Text(
              "($gottenStars.0)",
              style: const TextStyle(
                color: Colors.blueAccent
              ),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            Container(
              width: 50,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey.withOpacity(0.12)
              ),
              child: const Text('New',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(width: 5,),
            Container(
              width: 1,
              height: 15,
              color: Colors.black,
            ),
            const SizedBox(width: 5,),
            SizedBox(
              width: 110,
              child: Text(
                widget.car?.price ??'',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}