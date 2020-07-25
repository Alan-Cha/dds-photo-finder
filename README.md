# dds-photo-finder

A script to help my dad open up photo files based on how he likes to store his 
photos.

He stores his photos in `/Volumes` and in different folders corresponding to different uses.

* `Capture/`: raw photo
* `Select/`: desirable photos
* `Edit/`: edited photos
* `Final/`: presentable photos

For example, he may have files in:

```
/Volumes/photo-album1/Captured/my-photo1.jpg
/Volumes/photo-album1/Select/my-photo1.jpg
/Volumes/photo-album1/Edit/my-photo1.jpg
/Volumes/photo-album1/Final/my-photo1.jpg

/Volumes/photo-album2/Captured/my-photo1.jpg
/Volumes/photo-album2/Captured/my-photo2.jpg
/Volumes/photo-album2/Captured/my-photo3.jpg
/Volumes/photo-album2/Select/my-photo2.jpg
/Volumes/photo-album2/Select/my-photo3.jpg
/Volumes/photo-album2/Edit/my-photo3.jpg
```

### Usage

```
find-photos [-h] <photo file path in /Volumes>
```

***

On a Mac:

Assuming you have a file open in Preview and you would like to open the related files. 

First, go to the top of Preview, command + click the file path, click on the folder, which will bring up the folder in Finder. 

In Finder, right click the file, hold option, click "Copy "..." as Pathname", which will copy the file path into your clipboard.

Run the program which will open up the related files:

```
./find-photos.sh <FILE PATH>
```

Then you can command + click the file path of the Preview windows, click on the folders, then import them into Photos. 