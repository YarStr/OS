@echo off

rem ************************
rem Сценарий: which.cmd
rem Дата создания: 23/10/2021
rem Последенее изменение: 24/10/2021
rem Автор: Ярослав Страхов
rem E-mail: staya_03@mail.ru
rem ************************
rem Описание: определяет, является ли переданная строка
rem 		  внешней командой и, если является, выводит 
rem           полный путь до исполняемого файла этой команды
rem ************************
rem Файлы: не сохраняет файлов
rem ************************

setlocal EnableDelayedExpansion

set command=%1
set commandCheck=%command:"=%
set commandCheck=%commandCheck: =%

IF NOT DEFINED command (
	echo ИНФОРМАЦИЯ: Некорректный ввод данных
	exit /b 1
)

IF /i NOT  %command%==%commandCheck% (
	echo ИНФОРМАЦИЯ: Некорректный ввод данных
	exit /b 1
)

if /i %command%==/? (
	echo.
	echo WHICH [команда]
	
	echo.
	echo Описание:
    echo 	Отображает расположение команды, совпадающей с шаблоном поиска.
    echo 	Поиск выполняется в каталогах, указанных в переменной среды PATH.

	echo.
	echo Примечание. Эта программа возвращает код ошибки 0, если заверешение 
    echo             программы было успешным, 1 - если возникли ошибки, 2 - 
	echo             если команда не была найдена.

	echo Примеры:
	echo 	WHICH /?
	echo 	WHICH calc.exe
	
	exit /b 
)

set myPATHEXT=%PATHEXT%
set myPATHEXT=%myPATHEXT:.=!command!.% 

rem Обработка случая, когда пользователь ввёл команду без расширениея файла
rem Например: script.cmd <НАЗВАНИЕ>
FOR %%A IN (%myPATHEXT%) DO (
	set "pathOfCommand=!cd!\%%A"
	IF EXIST !pathOfCommand! (echo Путь до исполняемого файла команды: & echo !pathOfCommand! & exit /b 0)
)

FOR %%A IN ("%PATH:;=";"%") DO (
	FOR %%B IN (%myPATHEXT%) DO (
		set command=%%B
		set "pathOfCommand=%%~A\!command!"
		set pathOfCommand=!pathOfCommand:\\=\! 
		IF EXIST !pathOfCommand! (echo Путь до исполняемого файла команды: & echo !pathOfCommand! & exit /b 0)
)
)

rem Обработка случая, когда пользователь ввёл команду с расширением файла
rem Например: script.cmd <НАЗВАНИЕ>.exe
set command=%1
set "pathOfCommand=%cd%\%command%"
IF EXIST !pathOfCommand! (echo Путь до исполняемого файла команды: & echo !pathOfCommand! & exit /b 0)

FOR %%A IN ("%PATH:;=";"%") DO (
	set "pathOfCommand=%%~A\!command!"
	set pathOfCommand=!pathOfCommand:\\=\! 
	IF EXIST !pathOfCommand! (echo Путь до исполняемого файла команды: & echo !pathOfCommand! & exit /b 0)
)
)

echo ИНФОРМАЦИЯ: ведённая команда не явяется внешней, файлы по заданому шаблону не найдены
exit /b 2

endlocal
echo.

