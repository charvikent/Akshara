package com.aurospaces.neighbourhood.db.basemodel;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;



import java.util.Date;
import java.math.BigDecimal;


/**
 *
 * @author autogenerated
 */



public class BaseUser 
{

@Id
@GeneratedValue(strategy=GenerationType.AUTO)
		 /** Field mapping. **/
@Column(name= "id")
protected int id   = 0;

/** Field mapping. **/
@Column(name= "created_time")
protected Date createdTime ;

/** Field mapping. **/
@Column(name= "updated_time")
protected Date updatedTime ;

/** Field mapping. **/
@Column(name= "user_name")
protected String userName ;

/** Field mapping. **/
@Column(name= "password")
protected String password ;

/** Field mapping. **/
@Column(name= "mobile_number")
protected String mobileNumber ;

public int getId()
{
  return id;
}
public void setId(final int id)
{
  this.id = id;
}
public Date getCreatedTime()
{
  return createdTime;
}
public void setCreatedTime(final Date createdTime)
{
  this.createdTime = createdTime;
}
public Date getUpdatedTime()
{
  return updatedTime;
}
public void setUpdatedTime(final Date updatedTime)
{
  this.updatedTime = updatedTime;
}
public String getUserName()
{
  return userName;
}
public void setUserName(final String userName)
{
  this.userName = userName;
}
public String getPassword()
{
  return password;
}
public void setPassword(final String password)
{
  this.password = password;
}
public String getMobileNumber()
{
  return mobileNumber;
}
public void setMobileNumber(final String mobileNumber)
{
  this.mobileNumber = mobileNumber;
}

}