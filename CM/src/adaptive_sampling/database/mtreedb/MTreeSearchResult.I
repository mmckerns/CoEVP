/* DO-NOT-DELETE revisionify.begin() */
/*

                            Copyright (c) 2014.
               Lawrence Livermore National Security, LLC.
         Produced at the Lawrence Livermore National Laboratory
                             LLNL-CODE-656392.
                           All rights reserved.

This file is part of CoEVP, Version 1.0. Please also read this link -- http://www.opensource.org/licenses/index.php

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the disclaimer below.

   * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the disclaimer (as noted below)
     in the documentation and/or other materials provided with the
     distribution.

   * Neither the name of the LLNS/LLNL nor the names of its contributors
     may be used to endorse or promote products derived from this software
     without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL LAWRENCE LIVERMORE NATIONAL SECURITY, LLC,
THE U.S. DEPARTMENT OF ENERGY OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


Additional BSD Notice

1. This notice is required to be provided under our contract with the U.S.
   Department of Energy (DOE). This work was produced at Lawrence Livermore
   National Laboratory under Contract No. DE-AC52-07NA27344 with the DOE.

2. Neither the United States Government nor Lawrence Livermore National
   Security, LLC nor any of their employees, makes any warranty, express
   or implied, or assumes any liability or responsibility for the accuracy,
   completeness, or usefulness of any information, apparatus, product, or
   process disclosed, or represents that its use would not infringe
   privately-owned rights.

3. Also, reference herein to any specific commercial products, process, or
   services by trade name, trademark, manufacturer or otherwise does not
   necessarily constitute or imply its endorsement, recommendation, or
   favoring by the United States Government or Lawrence Livermore National
   Security, LLC. The views and opinions of authors expressed herein do not
   necessarily state or reflect those of the United States Government or
   Lawrence Livermore National Security, LLC, and shall not be used for
   advertising or product endorsement purposes.

*/
/* DO-NOT-DELETE revisionify.end() */
//
// File:        MTreeSearchResult.I
// Package:     MTree database
// 
// 
// 
// Description: Container for single data object resulting from MTree search
//

#ifdef DEBUG_CHECK_ASSERTIONS
#ifndef included_cassert
#define included_cassert
#include <cassert>
#endif
#endif

#ifdef DEBUG_NO_INLINE
#define inline
#endif

namespace mtreedb {

/*
*************************************************************************
*                                                                       *
* Default ctor, copy ctor, and copy assignment operator.                *
*                                                                       *
*************************************************************************
*/

inline
MTreeSearchResult::MTreeSearchResult()
:
   d_distance_to_query_point( -MTreePoint::getMaxDistance() ),
   d_data_object_id( MTreeObject::getUndefinedId() ),
   d_data_object_radius( -MTreePoint::getMaxDistance() ),
   d_is_valid_result(false)
{
}

inline
MTreeSearchResult::MTreeSearchResult(const MTreeSearchResult& result)
:
   d_query_point(result.d_query_point),
   d_distance_to_query_point(result.d_distance_to_query_point),
   d_data_object(result.d_data_object),
   d_data_object_id(result.d_data_object_id),
   d_data_object_point(result.d_data_object_point),
   d_data_object_radius(result.d_data_object_radius),
   d_is_valid_result(result.d_is_valid_result)
{
}

inline 
MTreeSearchResult& 
MTreeSearchResult::operator=(const MTreeSearchResult& rhs)
{
   d_query_point = rhs.d_query_point;
   d_distance_to_query_point = rhs.d_distance_to_query_point;
   d_data_object = rhs.d_data_object;
   d_data_object_id = rhs.d_data_object_id;
   d_data_object_point = rhs.d_data_object_point;
   d_data_object_radius = rhs.d_data_object_radius;
   d_is_valid_result = rhs.d_is_valid_result;

   return(*this);
}

/*
*************************************************************************
*                                                                       *
* Accessory functions to get data members.                              * 
*                                                                       *
*************************************************************************
*/

inline
const MTreeObject& MTreeSearchResult::getDataObject() const
{
   return( *(d_data_object.get()) );
}

inline 
double MTreeSearchResult::getDistanceToQueryPoint() const
{
   return( d_distance_to_query_point );
}

inline
const MTreePoint& MTreeSearchResult::getDataObjectPoint() const
{
   return( *(d_data_object_point.get()) );
}

inline 
double MTreeSearchResult::getDataObjectRadius() const
{
   return( d_data_object_radius );
}

inline
const MTreePoint& MTreeSearchResult::getQueryPoint() const
{
   return( *(d_query_point.get()) );
}

/*
*************************************************************************
*                                                                       *
* Less-than comparison operator for STL list sort() method.             *
*                                                                       *
*************************************************************************
*/

inline
int MTreeSearchResult::operator< (const MTreeSearchResult& rhs) const
{
   int ret_val = 0;
   if ( d_distance_to_query_point < rhs.d_distance_to_query_point ) {
      ret_val = 1;
   }
   return( ret_val );
}

/*
*************************************************************************
*                                                                       *
* Private ctor for MTree search result.                                 *
*                                                                       *
*************************************************************************
*/

inline 
MTreeSearchResult::MTreeSearchResult(MTreePointPtr query_point,
                                     MTreeEntryPtr entry)
:
   d_query_point(query_point),
   d_distance_to_query_point(MTreePoint::getMaxDistance()),
   d_data_object_id(entry->getDataObjectId()),
   d_data_object_point(entry->getPoint()),
   d_data_object_radius(entry->getRadius()),
   d_is_valid_result(true)
{
#ifdef DEBUG_CHECK_ASSERTIONS
   assert(query_point.get());
   assert(entry.get());
#endif
}

/*
*************************************************************************
*                                                                       *
* Private accessory functions to set data members.                      * 
*                                                                       *
*************************************************************************
*/

inline
void MTreeSearchResult::setQueryPoint(MTreePointPtr query_point) 
{
   d_query_point = query_point;
}

inline
void MTreeSearchResult::setDistanceToQueryPoint(double distance)
{
   d_distance_to_query_point = distance;
}

inline
bool MTreeSearchResult::isValidResult() const
{
   return( d_is_valid_result );
}


}

#ifdef DEBUG_NO_INLINE
#undef inline
#endif




