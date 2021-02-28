from google.cloud import storage
import translator
import os

def hello_gcs(event, context):
     """Triggered by a change to a Cloud Storage bucket.
     Args:
          event (dict): Event payload.
          context (google.cloud.functions.Context): Metadata for the event.
     """
     file = event
     fileExtension = file['name'].split('.')[2]
     os.mkdir('/tmp/tempLoc/')
     destination_file_name = "/tmp/tempLoc/tempFile.{}".format(fileExtension)
     client = storage.Client()
     bucket = client.bucket(file['bucket'])
     blob = bucket.blob(file['name'])
     blob.download_to_filename(destination_file_name)
     if translator.translate_document():
          print('Successfully translated!')
     else:
          print('Error')
