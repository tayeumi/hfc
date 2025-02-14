USE [master]
GO
/****** Object:  Database [NWManagement]    Script Date: 12/08/2015 11:33:49 ******/
CREATE DATABASE [NWManagement] ON  PRIMARY 
( NAME = N'NWManagement', FILENAME = N'D:\NWManagement\Data\NWManagement.mdf' , SIZE = 6760448KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NWManagement_log', FILENAME = N'D:\NWManagement\Data\NWManagement_log.LDF' , SIZE = 5121024KB , MAXSIZE = 2048GB , FILEGROWTH = 2048000KB )
GO
ALTER DATABASE [NWManagement] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NWManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NWManagement] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [NWManagement] SET ANSI_NULLS OFF
GO
ALTER DATABASE [NWManagement] SET ANSI_PADDING OFF
GO
ALTER DATABASE [NWManagement] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [NWManagement] SET ARITHABORT OFF
GO
ALTER DATABASE [NWManagement] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [NWManagement] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [NWManagement] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [NWManagement] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [NWManagement] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [NWManagement] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [NWManagement] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [NWManagement] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [NWManagement] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [NWManagement] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [NWManagement] SET  DISABLE_BROKER
GO
ALTER DATABASE [NWManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [NWManagement] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [NWManagement] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [NWManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [NWManagement] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [NWManagement] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [NWManagement] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [NWManagement] SET  READ_WRITE
GO
ALTER DATABASE [NWManagement] SET RECOVERY SIMPLE
GO
ALTER DATABASE [NWManagement] SET  MULTI_USER
GO
ALTER DATABASE [NWManagement] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [NWManagement] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'NWManagement', N'ON'
GO
USE [NWManagement]
GO
/****** Object:  Table [dbo].[NW_Dhcp_Customer]    Script Date: 12/08/2015 11:33:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Dhcp_Customer](
	[IpAddress] [nvarchar](50) NOT NULL,
	[MacAddress] [nvarchar](50) NULL,
	[MacAddress_CMTS] [nvarchar](50) NULL,
	[CustomerCode] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAddress] [nvarchar](500) NULL,
	[PoolIp] [nvarchar](50) NULL,
	[Bootfile] [nvarchar](50) NULL,
	[IpPublic] [nvarchar](50) NULL,
	[MacPc] [nvarchar](50) NULL,
	[PoolPublic] [nvarchar](50) NULL,
	[Location] [nvarchar](500) NULL,
	[Note] [nvarchar](50) NULL,
 CONSTRAINT [PK_NW_Dhcp_Customer] PRIMARY KEY CLUSTERED 
(
	[IpAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Interface]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Interface](
	[Interface] [nvarchar](50) NOT NULL,
	[SignalGroup] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_NW_Interface] PRIMARY KEY CLUSTERED 
(
	[Interface] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Dhcp_Ip]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Dhcp_Ip](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PoolIp] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[SubnetMask] [nvarchar](50) NULL,
	[Router] [nvarchar](50) NULL,
	[Broadcast] [nvarchar](50) NULL,
	[Dns] [nvarchar](50) NULL,
	[Range] [nvarchar](50) NULL,
	[Static] [bit] NULL,
 CONSTRAINT [PK_NW_Dhcp_Ip] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Device_Status]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Device_Status](
	[Interface] [nvarchar](50) NULL,
	[Modems] [int] NULL,
	[Hosts] [int] NULL,
	[DateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[NW_CurrentTrafic_CreateTable]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_CurrentTrafic_CreateTable]
@table nvarchar(50)
as
begin
	declare @query nvarchar(500)
	if Len(@table)>2
		begin
			IF (not EXISTS (SELECT * 
							 FROM INFORMATION_SCHEMA.TABLES 
							 WHERE 
							 TABLE_NAME = @table))               
			BEGIN	
				
				set @query= 'CREATE TABLE '+@table+'(MacAddress nvarchar(50),DS nvarchar(50),US nvarchar(50),DateTime datetime,CurrentDS nvarchar(50),CurrentUS nvarchar(50))'
				EXECUTE sp_executesql @query
			END
		end
end
GO
/****** Object:  Table [dbo].[NW_CurrentTrafic]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_CurrentTrafic](
	[MacAddress] [nvarchar](50) NOT NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Node]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Node](
	[NodeCode] [nvarchar](50) NOT NULL,
	[NodeName] [nvarchar](500) NULL,
	[NodeGroup] [nvarchar](500) NULL,
	[Total] [int] NULL,
	[Description] [nvarchar](500) NULL,
	[Path] [nvarchar](1000) NULL,
 CONSTRAINT [PK_NW_Node] PRIMARY KEY CLUSTERED 
(
	[NodeCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_OpticalSW]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_OpticalSW](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[IpAddress] [nvarchar](50) NULL,
	[ValueA] [float] NULL,
	[ValueB] [float] NULL,
	[DateTime] [datetime] NULL,
	[Status] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Device_Temp]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Device_Temp](
	[NodeName] [nvarchar](500) NULL,
	[Value1] [int] NULL,
	[Value2] [int] NULL,
	[DateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_InterfaceControllerWarning]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_InterfaceControllerWarning](
	[InterfaceController] [nvarchar](50) NULL,
	[Signal] [nvarchar](50) NULL,
	[Datetime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_InterfaceGauge]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_InterfaceGauge](
	[Interface] [nvarchar](50) NULL,
	[OIDIn] [nvarchar](50) NULL,
	[OIDOut] [nvarchar](50) NULL,
	[InBandwidth] [real] NULL,
	[OutBandwidth] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_InterfaceLog]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_InterfaceLog](
	[InterfaceName] [nvarchar](255) NULL,
	[FullName] [nvarchar](255) NULL,
	[Inbps] [real] NULL,
	[Outbps] [real] NULL,
	[InBandwidth] [float] NULL,
	[OutBandwidth] [float] NULL,
	[InPercentUtil] [real] NULL,
	[OutPercentUtil] [real] NULL,
	[DateTime] [datetime] NULL,
	[StrDate] [nvarchar](255) NULL,
	[LastSync] [datetime] NULL,
	[Status] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[NW_Trafic_Getlike]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Trafic_Getlike]
@MacAddress nvarchar(50),
@Month nvarchar(50),
@Year nvarchar(50)
as
begin
	declare @sql nvarchar(500)
	set @sql= 'select * from NW_Traffic_'+@Month+'_'+@Year+' where MacAddress like '+'''%'+@MacAddress + ''' order by DateTime ASC'
	print @sql
	EXECUTE sp_executesql @sql
end

--exec NW_Trafic_Getlike '92a9','8','2015'
GO
/****** Object:  StoredProcedure [dbo].[NW_Trafic_GetByDayMac]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Trafic_GetByDayMac]
@MacAddress nvarchar(50),
@Day nvarchar(50),
@Month nvarchar(50),
@Year nvarchar(50)
as
begin
	declare @sql nvarchar(500)
	set @sql= 'select * from NW_Traffic_'+@Month+'_'+@Year+' where MacAddress='''+@MacAddress+''' and Day(DateTime)='+''''+@Day + ''''
	print @sql
	EXECUTE sp_executesql @sql
end

--exec NW_Trafic_GetByDay '1','9','2015'
GO
/****** Object:  StoredProcedure [dbo].[NW_Trafic_GetByDay]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Trafic_GetByDay]
@Day nvarchar(50),
@Month nvarchar(50),
@Year nvarchar(50)
as
begin
	declare @sql nvarchar(500)
	set @sql= 'select * from NW_Traffic_'+@Month+'_'+@Year+' where Day(DateTime)='+''''+@Day + ''''
	print @sql
	EXECUTE sp_executesql @sql
end

--exec NW_Trafic_GetByDay '1','9','2015'
GO
/****** Object:  StoredProcedure [dbo].[NW_Trafic_Get]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Trafic_Get]
@MacAddress nvarchar(50),
@Month nvarchar(50),
@Year nvarchar(50)
as
begin
	declare @sql nvarchar(500)
	set @sql= 'select * from NW_Traffic_'+@Month+'_'+@Year+' where MacAddress='+''''+@MacAddress + ''' order by DateTime ASC'
	print @sql
	EXECUTE sp_executesql @sql
end

--exec NW_Trafic_Get '000e.0923.92a9','7','2015'
GO
/****** Object:  Table [dbo].[NW_Traffic_9_2015]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Traffic_9_2015](
	[MacAddress] [nvarchar](50) NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Traffic_8_2015]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Traffic_8_2015](
	[MacAddress] [nvarchar](50) NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Traffic_7_2015]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Traffic_7_2015](
	[MacAddress] [nvarchar](50) NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Traffic_12_2015]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Traffic_12_2015](
	[MacAddress] [nvarchar](50) NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Traffic_11_2015]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Traffic_11_2015](
	[MacAddress] [nvarchar](50) NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_Traffic_10_2015]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Traffic_10_2015](
	[MacAddress] [nvarchar](50) NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NW_SignalLog_5Day]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_SignalLog_5Day](
	[MacAddress] [nvarchar](50) NULL,
	[IpPrivate] [nvarchar](50) NULL,
	[IpPublic1] [nvarchar](50) NULL,
	[IpPublic2] [nvarchar](50) NULL,
	[Value1] [nvarchar](50) NULL,
	[Value2] [nvarchar](50) NULL,
	[Value3] [nvarchar](50) NULL,
	[Value4] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_5Day_GetByMacLike]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_SignalLog_5Day_GetByMacLike]
@MacAddress nvarchar(50)
as
begin
--exec [dbo].[NW_SignalLog_DeleteFor30Day]

select *,Convert(date,DateTime) as Date from NW_SignalLog_5Day
where MacAddress like '%'+ @MacAddress +'%'
order by DateTime Desc
end
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_5Day_GetByMac]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_SignalLog_5Day_GetByMac]
@MacAddress nvarchar(50)
as
begin
--exec [dbo].[NW_SignalLog_DeleteFor30Day]

select *,Convert(date,DateTime) as Date from NW_SignalLog_5Day
where MacAddress=@MacAddress
order by DateTime Asc
end
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_5Day_DeleteFor5Day]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_SignalLog_5Day_DeleteFor5Day]
as
begin
delete from NW_SignalLog_5Day
where DATEDIFF ( day,DateTime,GETDATE())>5
end
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceLog_DeleteFor30Day]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_InterfaceLog_DeleteFor30Day]
as
begin
delete from NW_InterfaceLog
where DATEDIFF ( day,DateTime,GETDATE())>30
end
GO
/****** Object:  StoredProcedure [dbo].[NW_OpticalSW_Update]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NW_OpticalSW_Update]
@ID int,
@Name nvarchar(100),
@IpAddress nvarchar(50)
AS
BEGIN
update NW_OpticalSW set Name=@Name,IpAddress=@IpAddress
where ID=@ID

END
GO
/****** Object:  StoredProcedure [dbo].[NW_OpticalSW_Insert]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NW_OpticalSW_Insert]
@Name nvarchar(100),
@IpAddress nvarchar(50)
AS
BEGIN
insert into NW_OpticalSW (Name,IpAddress) 
values (@Name,@IpAddress)

END
GO
/****** Object:  StoredProcedure [dbo].[NW_OpticalSW_Getlist]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_OpticalSW_Getlist]
AS
BEGIN
select * from NW_OpticalSW 
END
GO
/****** Object:  StoredProcedure [dbo].[NW_OpticalSW_Get]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_OpticalSW_Get]
@ID int
AS
BEGIN
select * from NW_OpticalSW where ID=@ID
END
GO
/****** Object:  StoredProcedure [dbo].[NW_OpticalSW_Delete]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_OpticalSW_Delete]
@ID int
AS
BEGIN
delete NW_OpticalSW 
where ID=@ID

END
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceGauge_GetList]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_InterfaceGauge_GetList]
AS
BEGIN

Select * From NW_InterfaceGauge  

END
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceControllerWarning_Insert]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_InterfaceControllerWarning_Insert]
@InterfaceController nvarchar(50),
@Signal nvarchar(50),
@Datetime Datetime
as
begin
insert into NW_InterfaceControllerWarning(InterfaceController,Signal,Datetime)
			values (@InterfaceController,@Signal,@Datetime)
end
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceControllerWarning_GetList_Low]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_InterfaceControllerWarning_GetList_Low]
as
begin
select * from NW_InterfaceControllerWarning
where CONVERT(float, Signal)<20 and Signal <>'0.0' and Signal <>''
end
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceControllerWarning_GetList]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_InterfaceControllerWarning_GetList]
as
begin
select * from NW_InterfaceControllerWarning
end
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceControllerWarning_DeleteAll]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_InterfaceControllerWarning_DeleteAll]
as
begin
delete from NW_InterfaceControllerWarning
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Interface_Insert]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Interface_Insert]
@Interface nvarchar(50),
@SignalGroup nvarchar(50),
@Description nvarchar(50)
AS
BEGIN
insert into NW_Interface (Interface,SignalGroup,Description) 
values (@Interface,@SignalGroup,@Description)

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Interface_Getlist]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Interface_Getlist]
AS
BEGIN
select * from NW_Interface 
END
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Status_Insert]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Device_Status_Insert]
@Interface nvarchar(50),
@Modems int,
@Hosts int,
@DateTime datetime
as
begin
insert into NW_Device_Status(Interface,Modems,Hosts,DateTime) values(@Interface,@Modems,@Hosts,@DateTime)
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Status_GetList]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Device_Status_GetList]
as
begin
select * from  NW_Device_Status 
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Status_GetByInterface]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Device_Status_GetByInterface]
@Interface nvarchar(50)
as
begin
select * from  NW_Device_Status where Interface=@Interface
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Status_Get24h]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Device_Status_Get24h]
as
begin
select * from NW_Device_Status
where DATEDIFF ( HOUR,DateTime,GETDATE())<24
end

--exec [dbo].[NW_Device_Status_Get24h]
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Status_DeleteFor30Day]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Device_Status_DeleteFor30Day]
as
begin
delete from NW_Device_Status
where DATEDIFF ( day,DateTime,GETDATE())>30
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Node_UpdateByPath]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Node_UpdateByPath]
@NodeCode nvarchar(50),
@Path nvarchar(1000)
AS
BEGIN

update NW_Node set Path=@Path
where
	NodeCode=@NodeCode			 

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Node_Update]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[NW_Node_Update]
@NodeCode nvarchar(50),
@NodeName nvarchar(500),
@NodeGroup nvarchar(500),
@Description nvarchar(500)
AS
BEGIN

update NW_Node set NodeName=@NodeName,NodeGroup=@NodeGroup,Description=@Description
where
	NodeCode=@NodeCode			 

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Node_Insert]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[NW_Node_Insert]
@NodeCode nvarchar(50),
@NodeName nvarchar(500),
@NodeGroup nvarchar(500),
@Description nvarchar(500)
AS
BEGIN

insert into  NW_Node( NodeCode,NodeName,NodeGroup,Description)
			 values(@NodeCode,@NodeName,@NodeGroup,@Description)

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Node_GetList]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[NW_Node_GetList]
AS
BEGIN

Select * From [NW_Node]   

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Node_Get]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[NW_Node_Get]
    @NodeCode nvarchar(50)

AS
BEGIN

Select * From [NW_Node]
 Where 
    [NodeCode] = @NodeCode


END
GO
/****** Object:  StoredProcedure [dbo].[NW_Node_Delete]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[NW_Node_Delete]
@NodeCode nvarchar(50)
AS
BEGIN

delete NW_Node 
where
	NodeCode=@NodeCode		 

END
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceLog_Insert]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_InterfaceLog_Insert]
@InterfaceName nvarchar(255),
@FullName nvarchar(255),
@Inbps real,
@Outbps real,
@InBandwidth float,
@OutBandwidth float,
@InPercentUtil real,
@OutPercentUtil real,
@DateTime Datetime,
@StrDate nvarchar(255),
@LastSync Datetime,
@Status	nvarchar(50)
as 
begin
	insert into NW_InterfaceLog(InterfaceName,FullName,Inbps,Outbps,InBandwidth,OutBandwidth,InPercentUtil,OutPercentUtil,DateTime,StrDate,LastSync,Status)
	values(@InterfaceName,@FullName,@Inbps,@Outbps,@InBandwidth,@OutBandwidth,@InPercentUtil,@OutPercentUtil,@DateTime,@StrDate,@LastSync,@Status)
end
GO
/****** Object:  Table [dbo].[NW_Device]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_Device](
	[MacAddress] [nvarchar](50) NOT NULL,
	[NodeCode] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](100) NULL,
	[CustomerAddress] [nvarchar](500) NULL,
	[Ward] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[CustomerTelephone] [nvarchar](50) NULL,
	[IpPrivate] [nvarchar](50) NULL,
	[IpPublic1] [nvarchar](50) NULL,
	[IpPublic2] [nvarchar](50) NULL,
	[Value1] [nvarchar](50) NULL,
	[Value2] [nvarchar](50) NULL,
	[Value3] [nvarchar](50) NULL,
	[Value4] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[Description] [nvarchar](500) NULL,
	[Checked] [bit] NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[OldDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL,
	[OldUS] [nvarchar](50) NULL,
	[DS] [nvarchar](50) NULL,
	[US] [nvarchar](50) NULL,
 CONSTRAINT [PK_NW_Device] PRIMARY KEY CLUSTERED 
(
	[MacAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[NW_CurrentTrafic_Insert]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_CurrentTrafic_Insert]
@MacAddress nvarchar(50),
@DS nvarchar(50),
@US nvarchar(50),
@DateTime datetime,
@CurrentDS nvarchar(50),
@CurrentUS nvarchar(50)
as
begin

insert into NW_CurrentTrafic(MacAddress,DS,US,DateTime,CurrentDS,CurrentUS)
values
(@MacAddress,@DS,@US,@DateTime,@CurrentDS,@CurrentUS)
end
GO
/****** Object:  StoredProcedure [dbo].[NW_CurrentTrafic_GetAll]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_CurrentTrafic_GetAll]
as
begin
select * from NW_CurrentTrafic
end
GO
/****** Object:  StoredProcedure [dbo].[NW_CurrentTrafic_DeleteAll]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_CurrentTrafic_DeleteAll]
as
begin
delete from NW_CurrentTrafic
end
GO
/****** Object:  Trigger [InsertToTrafficMonth]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[InsertToTrafficMonth]
on [dbo].[NW_CurrentTrafic]
for Insert as
Begin
	declare @table nvarchar(50)
	declare @month int
	declare @year int
	set @month=MONTH(getdate())
	set @year=Year(getdate()) 
	set @table='NW_Traffic_'+CONVERT(nvarchar(50),@month)+'_'+CONVERT(nvarchar(50),@year)+''		
	declare @query nvarchar(500)
	IF (not EXISTS (SELECT * 
							 FROM INFORMATION_SCHEMA.TABLES 
							 WHERE 
							 TABLE_NAME = @table))               
	BEGIN	
				
				set @query= 'CREATE TABLE '+@table+'(MacAddress nvarchar(50),DS nvarchar(50),US nvarchar(50),DateTime datetime,CurrentDS nvarchar(50),CurrentUS nvarchar(50))'
				EXECUTE sp_executesql @query
	END
	--declare @tb Table(MacAddress nvarchar(50),DS nvarchar(50),US nvarchar(50),DateTime datetime)
	
	declare			
	@MacAddress nvarchar(50),
	@DS nvarchar(50),
	@US nvarchar(50),	
	@DateTime datetime,
	@CurrentDS nvarchar(50),
	@CurrentUS nvarchar(50)
	
	Select @MacAddress=MacAddress,@DS=DS,@US=US,@DateTime=DateTime,@CurrentDS=CurrentDS,@CurrentUS=CurrentUS from inserted	
	set @query= 'insert into '+@table+'(MacAddress,DS,US,DateTime,CurrentDS,CurrentUS) values ('''+@MacAddress+''','''+@DS+''','''+@US+''','''+ convert(nvarchar(24),@DateTime,121)+''','''+@CurrentDS+''','''+@CurrentUS+''')'		
	--print @query
	EXECUTE sp_executesql @query	
end

-- insert into NW_CurrentTrafic (MacAddress,DS,US,DateTime) values ('dsds.dsds.dsds','10','10','2015-8-3 8:00:00')
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_UpdateIPStatic]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Dhcp_Customer_UpdateIPStatic]
@IpAddress nvarchar(50),
@IpPublic nvarchar(50),
@PoolPublic nvarchar(50),
@MacPc nvarchar(50),
@Note nvarchar(50)
as
begin
	update NW_Dhcp_Customer set IpPublic=@IpPublic,PoolPublic=@PoolPublic,MacPc=@MacPc,Note=@Note where IpAddress=@IpAddress
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_Update]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Customer_Update]
@IpAddress nvarchar(50),
@MacAddress nvarchar(50),
@MacAddress_CMTS	nvarchar(50),
@CustomerCode	nvarchar(50),
@CustomerName	nvarchar(50)	,
@CustomerAddress	nvarchar(500)	,
@Bootfile	nvarchar(50)	,
@Location nvarchar(500),
@Note	nvarchar(50)	
as
begin
	update NW_Dhcp_Customer set	
	MacAddress=@MacAddress,
	MacAddress_CMTS=@MacAddress_CMTS,
	CustomerCode=@CustomerCode,
	CustomerName=@CustomerName,
	CustomerAddress=@CustomerAddress,
	Bootfile=@Bootfile,
	Location=@Location,
	Note=@Note
	where 
	IpAddress=@IpAddress	
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_Insert]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Dhcp_Customer_Insert]
@IpAddress nvarchar(50),
@MacAddress nvarchar(50),
@MacAddress_CMTS	nvarchar(50),
@CustomerCode	nvarchar(50),
@CustomerName	nvarchar(50)	,
@CustomerAddress	nvarchar(500)	,
@PoolIp	nvarchar(50)	,
@Bootfile	nvarchar(50)	,
@IpPublic	nvarchar(50)	,
@MacPc	nvarchar(50)	,
@PoolPublic	nvarchar(50)	,
@Location nvarchar(500),
@Note	nvarchar(50)	
as
begin
	insert into NW_Dhcp_Customer
	(IpAddress,MacAddress,MacAddress_CMTS,CustomerCode,CustomerName,CustomerAddress,PoolIp,Bootfile,IpPublic,MacPc,PoolPublic,Location,Note)
	values
	(@IpAddress,@MacAddress,@MacAddress_CMTS,@CustomerCode,@CustomerName,@CustomerAddress,@PoolIp,@Bootfile,@IpPublic,@MacPc,@PoolPublic,@Location,@Note)
	
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_Getlist]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Customer_Getlist]
as
begin
	select * from NW_Dhcp_Customer

end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_GetbyPoolPublic]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Customer_GetbyPoolPublic]
 @PoolIp nvarchar(50)
  as
  begin
  select * from NW_Dhcp_Customer where PoolPublic=@PoolIp
  end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_GetbyPool]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Dhcp_Customer_GetbyPool]
 @PoolIp nvarchar(50)
  as
  begin
  select * from NW_Dhcp_Customer where PoolIp=@PoolIp
  end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_GetbyMacaddress]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Customer_GetbyMacaddress]
 @MacAddress nvarchar(50)
  as
  begin
  select * from NW_Dhcp_Customer where MacAddress=@MacAddress
  end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_GetbyIp]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Customer_GetbyIp]
 @IpAddress nvarchar(50)
  as
  begin
  select * from NW_Dhcp_Customer where IpAddress=@IpAddress
  end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_DeleteIPStatic]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Dhcp_Customer_DeleteIPStatic]
@IpAddress nvarchar(50)
as
begin
	update NW_Dhcp_Customer set IpPublic='',PoolPublic='',MacPc='' where IpAddress=@IpAddress
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_DeleteAll]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Customer_DeleteAll]
as
begin
delete from NW_Dhcp_Customer
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Customer_Delete]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Customer_Delete]
@IpAddress nvarchar(50)
as
begin
	delete from NW_Dhcp_Customer where IpAddress=@IpAddress
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Ip_Getlist]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Ip_Getlist]
as
begin
	select* from NW_Dhcp_Ip
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Ip_GetIPbyPool]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_Dhcp_Ip_GetIPbyPool]
@PoolIP nvarchar(50)
  as
  begin
  select * from NW_Dhcp_Ip where PoolIP =@PoolIP
  end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Ip_GetbyPoolModem]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Dhcp_Ip_GetbyPoolModem]
  as
  begin
  select * from NW_Dhcp_Ip where Name like '%Modem%'
  end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Ip_GetbyCPEStatic]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Dhcp_Ip_GetbyCPEStatic]
  as
  begin
  select * from NW_Dhcp_Ip where Name like 'CPE%' and Static=1
  end
GO
/****** Object:  StoredProcedure [dbo].[NW_Dhcp_Ip_GetbyCPEDynamic]    Script Date: 12/08/2015 11:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Dhcp_Ip_GetbyCPEDynamic]
  as
  begin
  select * from NW_Dhcp_Ip where Name like 'CPE%' and Static=0
  end
GO
/****** Object:  StoredProcedure [dbo].[Traffic_fix]    Script Date: 12/08/2015 11:34:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Traffic_fix]
as
begin
	declare @MacAddress nvarchar(50)
	declare @DS nvarchar(50)
	declare @US nvarchar(50)
	declare @DateTime Datetime
	declare @CurrentDS nvarchar(50)
	declare @CurrentUS nvarchar(50)
	
	declare @OldCurrentDS nvarchar(50)
	declare @CheckCurrentDS nvarchar(50)
	declare @OldCurrentUS nvarchar(50)
	
	DECLARE cs1 CURSOR FOR
	select MacAddress,DS,US,DateTime,CurrentDS,CurrentUS from NW_Traffic_9_2015 where MacAddress='001a.ad99.77bc' order by DateTime asc
	
	OPEN cs1
	fetch next from cs1 into @MacAddress,@DS,@US,@DateTime,@CurrentDS,@CurrentUS
	while @@FETCH_STATUS=0
	begin	
		if (@OldCurrentDS='0')
		begin
		  print @OldCurrentDS		  
		  print @CurrentDS
		end		
		set @OldCurrentDS=	@CurrentDS	
	fetch next from cs1 into @MacAddress,@DS,@US,@DateTime,@CurrentDS,@CurrentUS
	end
	close cs1
	deallocate cs1 
end

-- exec Traffic_fix
GO
/****** Object:  Trigger [UpdateTotalDevice_del]    Script Date: 12/08/2015 11:34:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[UpdateTotalDevice_del]
on [dbo].[NW_Device]
for Delete as
Begin
	declare @Total int
	Select @Total=COUNT(*) from NW_Device where NW_Device.NodeCode=(select NodeCode from deleted)
	update NW_Node set Total=@Total where NodeCode=(select NodeCode from deleted)
end
GO
/****** Object:  Trigger [UpdateTotalDevice]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[UpdateTotalDevice]
on [dbo].[NW_Device]
for Insert as
Begin
	declare @Total int
	Select @Total=COUNT(*) from NW_Device where NW_Device.NodeCode=(select NodeCode from inserted)
	update NW_Node set Total=@Total where NodeCode=(select NodeCode from inserted)
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_UpdateSignal]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NW_Device_UpdateSignal]
@MacAddress nvarchar(50),
@IpPrivate nvarchar(50),
@IpPublic1 nvarchar(50),
@IpPublic2 nvarchar(50),
@Value1 nvarchar(50),
@Value2 nvarchar(50),
@Value3 nvarchar(50),
@Value4 nvarchar(50),
@Location nvarchar(50),
@Status nvarchar(50),
@DateTime Datetime
AS
BEGIN

update [NW_Device] set
IpPrivate=@IpPrivate,
IpPublic1=@IpPublic1,
IpPublic2=@IpPublic2,
Value1=@Value1,
Value2=@Value2,
Value3=@Value3,
Value4=@Value4,
Location=@Location,
Status=@Status,
DateTime=@DateTime
where MacAddress=@MacAddress 

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Update]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Device_Update]
	@MacAddress nvarchar(50),
	@Value1 nvarchar(50),
	@Value2 nvarchar(50),
	@Value3 nvarchar(50),
	@DateTime datetime,
	@Status nvarchar(50)
AS
BEGIN

update  NW_Device set Value1=@Value1,Value2=@Value2,Value3=Value3,Status=@Status,DateTime=@DateTime					
	where MacAddress=@MacAddress

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Insert]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Device_Insert]
@MacAddress nvarchar(50),
@NodeCode nvarchar(50),
@Description nvarchar(500)
AS
BEGIN

insert into NW_Device(MacAddress,NodeCode,Description) 
					values (@MacAddress,@NodeCode,@Description)

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_GetStatic]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_Device_GetStatic]
as
begin
begin transaction
	--create table NW_Device_Temp(NodeName nvarchar(500), [Value1] int,[Value2] int)
	delete  from NW_Device_Temp
	DECLARE cs1 CURSOR FOR
	select NodeCode,NodeName from NW_Node where Total>0 and Total is not null
	Open cs1		
	declare @NodeCode nvarchar(50)
	declare @NodeName nvarchar(500)
	declare @value1 int
	declare @value2 int
	declare @DateTime datetime
	fetch next from cs1 into @NodeCode,@NodeName	
	while @@FETCH_STATUS=0
	begin
		select @value1=COUNT(*) from NW_Device where NodeCode=@NodeCode and Status='online'	
		select @value2=COUNT(*) from NW_Device where NodeCode=@NodeCode and Status='offline'
		select @DateTime=DateTime from NW_Device where NodeCode=@NodeCode	
	insert into NW_Device_Temp (NodeName,Value1,Value2,DateTime) values (@NodeName,@value1,@value2,@DateTime)
	fetch next from cs1 into @NodeCode,@NodeName
	end
	close cs1
	deallocate cs1 
	select NW_Device_Temp.*,NW_Node.Description,NW_Node.NodeCode,NW_Node.NodeGroup,NW_Node.Path from NW_Device_Temp inner join NW_Node on NW_Node.NodeName=NW_Device_Temp.NodeName
	--drop table TEMPORARY1
	if(@@error<>0) rollback transaction
	else commit
end
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_GetList]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Device_GetList]
AS
BEGIN

Select * From [NW_Device]   

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_GetByNodeCode]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Device_GetByNodeCode]
@NodeCode nvarchar(50)
AS
BEGIN

Select * From [NW_Device]  where NodeCode=@NodeCode

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_GetByMac]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NW_Device_GetByMac]
@MacAddress nvarchar(50)
AS
BEGIN

Select * From [NW_Device]  where MacAddress=@MacAddress 

END
GO
/****** Object:  StoredProcedure [dbo].[NW_Device_Delete]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NW_Device_Delete]
@MacAddress nvarchar(50)
AS
BEGIN

delete NW_Device
where MacAddress=@MacAddress

END
GO
/****** Object:  StoredProcedure [dbo].[NW_InterfaceLog_GetList]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NW_InterfaceLog_GetList]
AS
BEGIN
exec NW_InterfaceLog_DeleteFor30Day

select *from  NW_InterfaceLog

END
GO
/****** Object:  Table [dbo].[NW_SignalLog]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NW_SignalLog](
	[MacAddress] [nvarchar](50) NULL,
	[IpPrivate] [nvarchar](50) NULL,
	[IpPublic1] [nvarchar](50) NULL,
	[IpPublic2] [nvarchar](50) NULL,
	[Value1] [nvarchar](50) NULL,
	[Value2] [nvarchar](50) NULL,
	[Value3] [nvarchar](50) NULL,
	[Value4] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL,
	[Description] [nvarchar](500) NULL,
	[CurrentDS] [nvarchar](50) NULL,
	[CurrentUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_Insert]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_SignalLog_Insert]
@MacAddress nvarchar(50),
@IpPrivate nvarchar(50),
@IpPublic1 nvarchar(50),
@IpPublic2 nvarchar(50),
@Value1 nvarchar(50),
@Value2 nvarchar(50),
@Value3 nvarchar(50),
@Value4 nvarchar(50),
@Status nvarchar(50),
@Location nvarchar(50),
@DateTime datetime,
@Description nvarchar(50),
@CurrentDS nvarchar(50),
@CurrentUS nvarchar(50)
as
begin

insert into NW_SignalLog(MacAddress,IpPrivate,IpPublic1,IpPublic2,Value1,Value2,Value3,Value4,Status,Location,DateTime,Description,CurrentDS,CurrentUS)
values
(@MacAddress,@IpPrivate,@IpPublic1,@IpPublic2,@Value1,@Value2,@Value3,@Value4,@Status,@Location,@DateTime,@Description,@CurrentDS,@CurrentUS)

end
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_GetByMacDate]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_SignalLog_GetByMacDate]
@MacAddress nvarchar(50)
as
begin
--exec [dbo].[NW_SignalLog_DeleteFor30Day]

select *,Convert(date,DateTime) as Date from NW_SignalLog
where MacAddress=@MacAddress
and 
(Day(DateTime)=DAY(getdate()) and MONTH(DateTime)=MONTH(getdate()) and YEAR(DateTime)=YEAR(getdate()))
order by DateTime Asc
end
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_GetByMac]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NW_SignalLog_GetByMac]
@MacAddress nvarchar(50)
as
begin
--exec [dbo].[NW_SignalLog_DeleteFor30Day]

select *,Convert(date,DateTime) as Date from NW_SignalLog
where MacAddress=@MacAddress
order by DateTime Asc
end
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_DeleteFor30Day]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_SignalLog_DeleteFor30Day]
as
begin
delete from NW_SignalLog
where DATEDIFF ( day,DateTime,GETDATE())>30
end
GO
/****** Object:  StoredProcedure [dbo].[NW_SignalLog_DeleteAll]    Script Date: 12/08/2015 11:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NW_SignalLog_DeleteAll]
as
begin

delete from NW_SignalLog

end
GO
/****** Object:  Trigger [InsertToSignalLog5Day]    Script Date: 12/08/2015 11:34:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[InsertToSignalLog5Day]
on [dbo].[NW_SignalLog]
for Insert as
Begin	
	declare
	@MacAddress nvarchar(50),
	@IpPrivate nvarchar(50),
	@IpPublic1 nvarchar(50),
	@IpPublic2 nvarchar(50),
	@Value1 nvarchar(50),
	@Value2 nvarchar(50),
	@Value3 nvarchar(50),
	@Value4 nvarchar(50),
	@Status nvarchar(50),
	@Location nvarchar(50),
	@DateTime datetime,
	@Description nvarchar(50)
			
	Select @MacAddress=MacAddress,@IpPrivate=IpPrivate,@IpPublic1=IpPublic1,@IpPublic2=IpPublic2,@Value1=Value1,@Value2=Value2,@Value3=Value3,@Value4=Value4,@Status=Status,@Location=Location,@DateTime=DateTime,@Description=Description from inserted
	
	insert into NW_SignalLog_5Day(MacAddress,IpPrivate,IpPublic1,IpPublic2,Value1,Value2,Value3,Value4,Status,Location,DateTime,Description)
		values
		(@MacAddress,@IpPrivate,@IpPublic1,@IpPublic2,@Value1,@Value2,@Value3,@Value4,@Status,@Location,@DateTime,@Description)
		
	update  NW_Device set IpPrivate=@IpPrivate,IpPublic1=@IpPublic1,IpPublic2=@IpPublic2,Value1=@Value1,Value2=@Value2,Value3=Value3,Value4=@Value4,Status=@Status,Location=@Location,DateTime=@DateTime					
	where MacAddress=@MacAddress
end
GO
