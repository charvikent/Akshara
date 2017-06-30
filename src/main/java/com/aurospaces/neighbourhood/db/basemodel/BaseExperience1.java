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



public class BaseExperience1 
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
@Column(name= "old_experience_id")
protected String oldExperienceId ;

/** Field mapping. **/
@Column(name= "name")
protected String name ;

/** Field mapping. **/
@Column(name= "description")
protected String description ;

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
public String getOldExperienceId()
{
  return oldExperienceId;
}
public void setOldExperienceId(final String oldExperienceId)
{
  this.oldExperienceId = oldExperienceId;
}
public String getName()
{
  return name;
}
public void setName(final String name)
{
  this.name = name;
}
public String getDescription()
{
  return description;
}
public void setDescription(final String description)
{
  this.description = description;
}

}