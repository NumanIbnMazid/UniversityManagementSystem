USE [master]
GO
/****** Object:  Database [DebuggerUniversityManagementDB]    Script Date: 06-Jun-18 2:12:14 AM ******/
CREATE DATABASE [DebuggerUniversityManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DebuggerUniversityManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DebuggerUniversityManagementDB.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'VoidUniversityManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DebuggerUniversityManagementDB_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DebuggerUniversityManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [DebuggerUniversityManagementDB]
GO
/****** Object:  StoredProcedure [dbo].[spAddCourse]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddCourse]
@Code nvarchar(50),
@Name nvarchar(50),
@Credit float,
@Description nvarchar(max),
@DepartmentId int,
@SemesterId int
AS
BEGIN
INSERT INTO t_Course VALUES(@Code,@Name,@Credit,@Description,@DepartmentId,@SemesterId);
END





GO
/****** Object:  StoredProcedure [dbo].[spAddStudent]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddStudent]
@Name nvarchar(50),
@RegNo nvarchar(20),
@Email nvarchar(50),
@ContactNo nvarchar(20),
@RegisterationDate datetime,
@Address nvarchar(50),
@DepartmentId int
AS
BEGIN
INSERT INTO t_Student VALUES(@Name,@RegNo,@Email,@ContactNo,@RegisterationDate,@Address,@DepartmentId);
END





GO
/****** Object:  StoredProcedure [dbo].[spAddTeacher]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddTeacher]
@Name nvarchar(50),
@Address nvarchar(Max),
@Email nvarchar(50),
@Contact nvarchar(50),
@DesignationId int,
@DepartmentId int,
@CreditTobeTaken float,
@RemainingCredit float
AS
BEGIN

INSERT INTO t_Teacher VALUES(@Name,@Address,@Email,@Contact, @DesignationId,@DepartmentId,@CreditTobeTaken,@RemainingCredit)
END






GO
/****** Object:  StoredProcedure [dbo].[spClassScheduleAndClassRoomAllocation]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spClassScheduleAndClassRoomAllocation]
AS
BEGIN
SELECT d.Id as DepartmentId,c.Code,c.Name,COALESCE(t_Room.Name,'Not sheduled yet') AS Room_Name,t_Day.Name as Day_Name,r.StartTime,r.EndTime as EndTime
FROM t_Course c  LEFT OUTER JOIN t_AllocateClassRoom r
ON r.CourseId=c.Id LEFT OUTER JOIN t_Room  
ON r.RoomId=t_Room.Id LEFT OUTER JOIN t_Day 
ON r.DayId=t_Day.Id LEFT OUTER JOIN t_Departments d ON c.DepartmentId=d.Id 
END





GO
/****** Object:  StoredProcedure [dbo].[spDepartmentInformationWithTeacher]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDepartmentInformationWithTeacher]
As
BEGIN
SELECT d.Id,d.Code,d.Name, COALESCE(t.Name,'Not Assign yet') as Teacher,t.Email,t.Contact FROM t_Departments d LEFT OUTER JOIN t_Teacher t ON d.Id=t.DepartmentId
END






GO
/****** Object:  StoredProcedure [dbo].[spGetCourseByStudentId]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCourseByStudentId]
@Id  int
AS
 BEGIN
Select C.Id,c.Code,c.Name,c.Credit,c.Descirption,c.DepartmentId,c.SemesterId FROM t_Departments d INNER JOIN t_Course c ON d.Id=c.DepartmentId AND d.Id=(SELECT s.DepartmentId FROM t_Student s WHERE s.Id=@Id)
END





GO
/****** Object:  StoredProcedure [dbo].[spGetCourseInformation]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCourseInformation]
AS
BEGIN
SELECT d.Id as DepartmentId,COALESCE(c.Code,'Not Assigned yet') AS Code,COALESCE(c.Name,'Not Assigned yet') AS Name,COALESCE(s.Name,'Not Assigned yet') as Semester,COALESCE(t.Name,'Not Assigned yet')  as Teacher FROM  t_Departments d  LEFT OUTER JOIN t_Course  c  ON d.Id=c.DepartmentId LEFT OUTER JOIN  t_Semester s ON c.SemesterId=s.Id  LEFT OUTER JOIN t_CourseAssignToTeacher Ct  ON (c.Id=Ct.CourseId AND Ct.IsActive=1) LEFT OUTER JOIN t_Teacher t ON t.Id=Ct.TeacherId ORDER BY c.Code
END





GO
/****** Object:  StoredProcedure [dbo].[spGetCoursesTakenByaStudent]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCoursesTakenByaStudent]
  @StudentId int
  AS
  BEGIN
  SELECT c.Id,c.Code,c.Name,c.Credit,c.Descirption,c.DepartmentId,c.SemesterId FROM t_Course c INNER JOIN t_StudentEnrollInCourse r ON (c.Id=r.CourseId AND r.StudentId=@StudentId AND r.IsStudentActive=1)
  END





GO
/****** Object:  StoredProcedure [dbo].[spGetStudentInformationById]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[spGetStudentInformationById]
  @Id int
  AS
  BEGIN

  SELECT s.Id,s.RegNo,s.Name,s.Email,s.ContactNo,s.RegisterationDate,s.Address,d.Name as Department FROM t_Student s INNER JOIN t_Departments d ON s.DepartmentId=d.Id AND s.Id=@Id
  END





GO
/****** Object:  StoredProcedure [dbo].[spGetStudentResult]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetStudentResult]
@studentId int
AS
BEGIN
SELECT en.StudentId, c.Code,c.Name,COALESCE(r.Grade,'Not Graded yet') as Grade FROM t_StudentResult r RIGHT OUTER JOIN ( SELECT e.Id,e.StudentId,e.CourseId FROM t_StudentEnrollInCourse e WHERE e.StudentId=@studentId AND e.IsStudentActive=1) en ON r.CourseId=en.CourseId AND r.StudentId=en.StudentId AND r.IsStudentActive=1 INNER JOIN t_Course c ON en.CourseId=c.Id
END





GO
/****** Object:  Table [dbo].[t_AllocateClassRoom]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_AllocateClassRoom](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[RoomId] [int] NOT NULL,
	[DayId] [int] NOT NULL,
	[StartTime] [varchar](50) NOT NULL,
	[EndTime] [varchar](50) NOT NULL,
	[AllocationStatus] [bit] NULL,
 CONSTRAINT [PK_t_AllocateClassRoom] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[t_Course]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Course](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Credit] [float] NOT NULL,
	[Descirption] [nvarchar](max) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
 CONSTRAINT [PK_t_Course] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_CourseAssignToTeacher]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_CourseAssignToTeacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[TeacherId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_t_CourseAssignToTeacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_Day]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Day](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_t_Day] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_Departments]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Departments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](7) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_t_Departments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_Designation]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Designation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
 CONSTRAINT [PK_t_Designation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_Room]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Room](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_t_Room] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_Semester]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Semester](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_t_Semester] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_Student]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RegNo] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[ContactNo] [nvarchar](20) NOT NULL,
	[RegisterationDate] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[DepartmentId] [int] NOT NULL,
 CONSTRAINT [PK_t_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_StudentEnrollInCourse]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_StudentEnrollInCourse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[EnrollDate] [nvarchar](50) NOT NULL,
	[IsStudentActive] [bit] NULL,
 CONSTRAINT [PK_t_StudentEnrollInCourse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_StudentResult]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_StudentResult](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Grade] [nvarchar](5) NOT NULL,
	[IsStudentActive] [bit] NULL,
 CONSTRAINT [PK_t_StudentResult] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t_Teacher]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Contact] [nvarchar](50) NOT NULL,
	[DesignationId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CreditToBeTaken] [float] NOT NULL,
	[CreditTaken] [float] NOT NULL,
 CONSTRAINT [PK_t_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[GetStudentResult]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GetStudentResult]
AS
SELECT en.StudentId, c.Code,c.Name,COALESCE(r.Grade,'Not Graded yet') as Grade,r.IsStudentActive FROM t_StudentResult r RIGHT OUTER JOIN ( SELECT e.Id,e.StudentId,e.CourseId FROM t_StudentEnrollInCourse e WHERE  e.IsStudentActive=1) en ON r.CourseId=en.CourseId AND r.StudentId=en.StudentId INNER JOIN t_Course c ON en.CourseId=c.Id






GO
/****** Object:  View [dbo].[ScheduleOfClass]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ScheduleOfClass]
AS
SELECT d.Id as DepartmentId,c.Id AS CourseId,c.Code,c.Name,COALESCE(t_Room.Name,'Not sheduled yet') AS Room_Name,COALESCE(t_Day.Name,'Not sheduled yet') as Day_Name,

case when r.StartTime IS NULL THEN '00:00:00.0000000'
else CONVERT(varchar, r.StartTime) end as StartTime,
case when r.EndTime IS NULL THEN '00:00:00.0000000'
else CONVERT(varchar, r.EndTime) end as EndTime,
COALESCE(AllocationStatus,0) AS AllocationStatus
FROM t_Course c  LEFT OUTER JOIN t_AllocateClassRoom r
ON r.CourseId=c.Id LEFT OUTER JOIN t_Room  
ON r.RoomId=t_Room.Id LEFT OUTER JOIN t_Day 
ON r.DayId=t_Day.Id LEFT OUTER JOIN t_Departments d ON c.DepartmentId=d.Id 







GO
/****** Object:  View [dbo].[StudentResult]    Script Date: 06-Jun-18 2:12:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create VIEW [dbo].[StudentResult]
AS
SELECT c.Id,c.Code,c.Name,r.Grade FROM t_Course c INNER JOIN ( SELECT r.Id,r.StudentId,r.CourseId,r.Grade FROM t_StudentResult r WHERE StudentId=2 ) r  ON  c.Id=r.CourseId 







GO
ALTER TABLE [dbo].[t_AllocateClassRoom] ADD  CONSTRAINT [DF_t_AllocateClassRoom_AllocationStatus]  DEFAULT ((1)) FOR [AllocationStatus]
GO
ALTER TABLE [dbo].[t_CourseAssignToTeacher] ADD  CONSTRAINT [DF_t_CourseAssignToTeacher_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[t_StudentEnrollInCourse] ADD  CONSTRAINT [DF_t_StudentEnrollInCourse_IsStudentActive]  DEFAULT ((1)) FOR [IsStudentActive]
GO
ALTER TABLE [dbo].[t_StudentResult] ADD  CONSTRAINT [DF_t_StudentResult_IsStudentActive]  DEFAULT ((1)) FOR [IsStudentActive]
GO
ALTER TABLE [dbo].[t_AllocateClassRoom]  WITH CHECK ADD  CONSTRAINT [FK_t_AllocateClassRoom_t_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[t_Course] ([Id])
GO
ALTER TABLE [dbo].[t_AllocateClassRoom] CHECK CONSTRAINT [FK_t_AllocateClassRoom_t_Course]
GO
ALTER TABLE [dbo].[t_AllocateClassRoom]  WITH CHECK ADD  CONSTRAINT [FK_t_AllocateClassRoom_t_Day] FOREIGN KEY([DayId])
REFERENCES [dbo].[t_Day] ([Id])
GO
ALTER TABLE [dbo].[t_AllocateClassRoom] CHECK CONSTRAINT [FK_t_AllocateClassRoom_t_Day]
GO
ALTER TABLE [dbo].[t_AllocateClassRoom]  WITH CHECK ADD  CONSTRAINT [FK_t_AllocateClassRoom_t_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[t_Departments] ([Id])
GO
ALTER TABLE [dbo].[t_AllocateClassRoom] CHECK CONSTRAINT [FK_t_AllocateClassRoom_t_Departments]
GO
ALTER TABLE [dbo].[t_AllocateClassRoom]  WITH CHECK ADD  CONSTRAINT [FK_t_AllocateClassRoom_t_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[t_Room] ([Id])
GO
ALTER TABLE [dbo].[t_AllocateClassRoom] CHECK CONSTRAINT [FK_t_AllocateClassRoom_t_Room]
GO
ALTER TABLE [dbo].[t_Course]  WITH CHECK ADD  CONSTRAINT [FK_t_Course_t_Semester] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[t_Departments] ([Id])
GO
ALTER TABLE [dbo].[t_Course] CHECK CONSTRAINT [FK_t_Course_t_Semester]
GO
ALTER TABLE [dbo].[t_Course]  WITH CHECK ADD  CONSTRAINT [FK_t_Course_t_Semester1] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[t_Semester] ([Id])
GO
ALTER TABLE [dbo].[t_Course] CHECK CONSTRAINT [FK_t_Course_t_Semester1]
GO
ALTER TABLE [dbo].[t_CourseAssignToTeacher]  WITH CHECK ADD  CONSTRAINT [FK_t_CourseAssignToTeacher_t_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[t_Course] ([Id])
GO
ALTER TABLE [dbo].[t_CourseAssignToTeacher] CHECK CONSTRAINT [FK_t_CourseAssignToTeacher_t_Course]
GO
ALTER TABLE [dbo].[t_CourseAssignToTeacher]  WITH CHECK ADD  CONSTRAINT [FK_t_CourseAssignToTeacher_t_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[t_Departments] ([Id])
GO
ALTER TABLE [dbo].[t_CourseAssignToTeacher] CHECK CONSTRAINT [FK_t_CourseAssignToTeacher_t_Departments]
GO
ALTER TABLE [dbo].[t_CourseAssignToTeacher]  WITH CHECK ADD  CONSTRAINT [FK_t_CourseAssignToTeacher_t_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[t_Teacher] ([Id])
GO
ALTER TABLE [dbo].[t_CourseAssignToTeacher] CHECK CONSTRAINT [FK_t_CourseAssignToTeacher_t_Teacher]
GO
ALTER TABLE [dbo].[t_StudentEnrollInCourse]  WITH CHECK ADD  CONSTRAINT [FK_t_StudentEnrollInCourse_t_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[t_Course] ([Id])
GO
ALTER TABLE [dbo].[t_StudentEnrollInCourse] CHECK CONSTRAINT [FK_t_StudentEnrollInCourse_t_Course]
GO
ALTER TABLE [dbo].[t_StudentEnrollInCourse]  WITH CHECK ADD  CONSTRAINT [FK_t_StudentEnrollInCourse_t_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[t_Student] ([Id])
GO
ALTER TABLE [dbo].[t_StudentEnrollInCourse] CHECK CONSTRAINT [FK_t_StudentEnrollInCourse_t_Student]
GO
ALTER TABLE [dbo].[t_StudentResult]  WITH CHECK ADD  CONSTRAINT [FK_t_StudentResult_t_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[t_Course] ([Id])
GO
ALTER TABLE [dbo].[t_StudentResult] CHECK CONSTRAINT [FK_t_StudentResult_t_Course]
GO
ALTER TABLE [dbo].[t_StudentResult]  WITH CHECK ADD  CONSTRAINT [FK_t_StudentResult_t_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[t_Student] ([Id])
GO
ALTER TABLE [dbo].[t_StudentResult] CHECK CONSTRAINT [FK_t_StudentResult_t_Student]
GO
ALTER TABLE [dbo].[t_Teacher]  WITH CHECK ADD  CONSTRAINT [FK_t_Teacher_t_Designation] FOREIGN KEY([DesignationId])
REFERENCES [dbo].[t_Designation] ([Id])
GO
ALTER TABLE [dbo].[t_Teacher] CHECK CONSTRAINT [FK_t_Teacher_t_Designation]
GO
ALTER TABLE [dbo].[t_Teacher]  WITH CHECK ADD  CONSTRAINT [FK_t_Teacher_t_Teacher] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[t_Departments] ([Id])
GO
ALTER TABLE [dbo].[t_Teacher] CHECK CONSTRAINT [FK_t_Teacher_t_Teacher]
GO
USE [master]
GO
ALTER DATABASE [DebuggerUniversityManagementDB] SET  READ_WRITE 
GO
