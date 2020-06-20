import shutil #copy files
import os     #delete files
import glob   #Search for path name
import datetime as dt
import csv

def init():
    #Delete all txt files in folder_target
    filelist = glob.glob(os.path.join('folder_target', "*.txt"))
    print(filelist)
    for f in filelist:
        os.remove(f)


def copyImage():
    sourceDir = 'folder_source/'
    targetDir = 'folder_target/'
    filelist = glob.glob(os.path.join(sourceDir, "*Dark*.txt"))
    #filelist = [f for f in os.listdir(sourceDir)]
    #output: ['Dark1.txt', 'Dark2.txt', 'testFile1.txt', 'testFile2.txt']
    
    print(filelist)
    for f in filelist:
        filename=str(f)
        #shutil.copy2('folder_source/Dark1.txt', 'folder_target/')
        shutil.copy2(f, targetDir)

        #write to log file
        csv_filename = "FileTransferLog.txt"
        with open(csv_filename, 'a', newline='') as csvFile:
            #need to include newline='' otherwise Windows text mode will transate each \n into \r\n
            writer = csv.writer(csvFile)
            writer.writerow(str(filename))

        csvFile.close()


def createLogFile():
    #Generate a CSV file with log transfer info
    #csv_filename = "FileTransferLog_" +str(dt.datetime.now().strftime("%Y%m%d_%H-%M")) + ".csv"
    csv_filename = "FileTransferLog.txt"
    
    filepath = os.getcwd()+"\\"+csv_filename
    print(filepath)
    row = ["File name"]
    with open(filepath, 'w', newline='') as csvFile:
        writer = csv.writer(csvFile)
        writer.writerow(row)
    csvFile.close()


if __name__ == "__main__":
    #init()
    createLogFile()
    copyImage()
    '''
    while True:
        root.update_idletasks()
        root.update()  #This blocks
    '''