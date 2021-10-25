@echo off

rem ************************
rem �業�਩: which.cmd
rem ��� ᮧ�����: 23/10/2021
rem ��᫥����� ���������: 24/10/2021
rem ����: ��᫠� ���客
rem E-mail: staya_03@mail.ru
rem ************************
rem ���ᠭ��: ��।����, ���� �� ��।����� ��ப�
rem 		  ���譥� �������� �, �᫨ ����, �뢮��� 
rem           ����� ���� �� �ᯮ��塞��� 䠩�� �⮩ �������
rem ************************
rem �����: �� ��࠭�� 䠩���
rem ************************

setlocal EnableDelayedExpansion

set command=%1
set commandCheck=%command:"=%
set commandCheck=%commandCheck: =%

IF NOT DEFINED command (
	echo ����������: �����४�� ���� ������
	exit /b 1
)

IF /i NOT  %command%==%commandCheck% (
	echo ����������: �����४�� ���� ������
	exit /b 1
)

if /i %command%==/? (
	echo.
	echo WHICH [�������]
	
	echo.
	echo ���ᠭ��:
    echo 	�⮡ࠦ��� �ᯮ������� �������, ᮢ�����饩 � 蠡����� ���᪠.
    echo 	���� �믮������ � ��⠫����, 㪠������ � ��६����� �।� PATH.

	echo.
	echo �ਬ�砭��. �� �ணࠬ�� �����頥� ��� �訡�� 0, �᫨ �����襭�� 
    echo             �ணࠬ�� �뫮 �ᯥ��, 1 - �᫨ �������� �訡��, 2 - 
	echo             �᫨ ������� �� �뫠 �������.

	echo �ਬ���:
	echo 	WHICH /?
	echo 	WHICH calc.exe
	
	exit /b 
)

set myPATHEXT=%PATHEXT%
set myPATHEXT=%myPATHEXT:.=!command!.% 

rem ��ࠡ�⪠ ����, ����� ���짮��⥫� ��� ������� ��� ���७��� 䠩��
rem ���ਬ��: script.cmd <��������>
FOR %%A IN (%myPATHEXT%) DO (
	set "pathOfCommand=!cd!\%%A"
	IF EXIST !pathOfCommand! (echo ���� �� �ᯮ��塞��� 䠩�� �������: & echo !pathOfCommand! & exit /b 0)
)

FOR %%A IN ("%PATH:;=";"%") DO (
	FOR %%B IN (%myPATHEXT%) DO (
		set command=%%B
		set "pathOfCommand=%%~A\!command!"
		set pathOfCommand=!pathOfCommand:\\=\! 
		IF EXIST !pathOfCommand! (echo ���� �� �ᯮ��塞��� 䠩�� �������: & echo !pathOfCommand! & exit /b 0)
)
)

rem ��ࠡ�⪠ ����, ����� ���짮��⥫� ��� ������� � ���७��� 䠩��
rem ���ਬ��: script.cmd <��������>.exe
set command=%1
set "pathOfCommand=%cd%\%command%"
IF EXIST !pathOfCommand! (echo ���� �� �ᯮ��塞��� 䠩�� �������: & echo !pathOfCommand! & exit /b 0)

FOR %%A IN ("%PATH:;=";"%") DO (
	set "pathOfCommand=%%~A\!command!"
	set pathOfCommand=!pathOfCommand:\\=\! 
	IF EXIST !pathOfCommand! (echo ���� �� �ᯮ��塞��� 䠩�� �������: & echo !pathOfCommand! & exit /b 0)
)
)

echo ����������: ���񭭠� ������� �� ����� ���譥�, 䠩�� �� �������� 蠡���� �� �������
exit /b 2

endlocal
echo.

