import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PackageController extends GetxController {
  // Observable variables to track video status and metadata
  var isVideoTaken = false.obs;
  var videoPath = ''.obs;
  var videoThumbnailPath = ''.obs;
  var videoDuration = ''.obs;

  final ImagePicker _picker = ImagePicker();

  // Method to trigger video recording
  Future<void> takeVideo() async {
    try {
      // Launch the camera to record a video
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 1),
      );

      if (video != null) {
        // Store the video path
        videoPath.value = video.path;

        // Generate the video thumbnail
        String thumbnailPath = await _generateThumbnail(video.path);
        videoThumbnailPath.value = thumbnailPath;

        // Get the video duration
        String duration = await _getVideoDuration(video.path);
        videoDuration.value = duration;

        // Update the status
        isVideoTaken.value = true;
      } else {
        isVideoTaken.value = false;
      }
    } catch (e) {
      print("Error recording video: $e");
    }
  }

  // Generate a thumbnail using ffmpeg
  Future<String> _generateThumbnail(String videoFilePath) async {
    String thumbnailPath = "${videoFilePath}_thumbnail.jpg";
    await FFmpegKit.execute(
        '-i $videoFilePath -ss 00:00:01 -vframes 1 $thumbnailPath');
    return thumbnailPath;
  }

  // Fetch the video duration using ffmpeg
  Future<String> _getVideoDuration(String videoFilePath) async {
    String duration = "00:00";

    // Execute the FFmpeg command and await the session result
    await FFmpegKit.execute('-i $videoFilePath -hide_banner').then((session) async {
      // Get the output of the session
      final sessionOutput = await session.getOutput();
      print("FFmpeg Output: $sessionOutput"); // Debugging output

      if (sessionOutput != null) {
        // Match the 'Duration:' line using RegExp
        final durationMatch = RegExp(r'Duration:\s(\d+:\d+:\d+)').firstMatch(sessionOutput);
        if (durationMatch != null) {
          duration = durationMatch.group(1)!; // Extracted duration
        } else {
          print("Duration not found in FFmpeg output.");
        }
      } else {
        print("No output received from FFmpeg.");
      }
    });

    return duration;
  }


}
