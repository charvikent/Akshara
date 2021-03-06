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



public class BaseOrderSequence 
{

@Id
@GeneratedValue(strategy=GenerationType.AUTO)
		 /** Field mapping. **/
@Column(name= "id")
protected int id   = 0;

/** Field mapping. **/
@Column(name= "service_id")
protected int serviceId ;

/** Field mapping. **/
@Column(name= "sequence_string")
protected String sequenceString ;

public int getId()
{
  return id;
}
public void setId(final int id)
{
  this.id = id;
}
public int getServiceId()
{
  return serviceId;
}
public void setServiceId(final int serviceId)
{
  this.serviceId = serviceId;
}
public String getSequenceString()
{
  return sequenceString;
}
public void setSequenceString(final String sequenceString)
{
  this.sequenceString = sequenceString;
}

}