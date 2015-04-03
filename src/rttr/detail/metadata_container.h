/************************************************************************************
*                                                                                   *
*   Copyright (c) 2014, 2015 Axel Menzel <info@axelmenzel.de>                       *
*                                                                                   *
*   This file is part of RTTR (Run Time Type Reflection)                            *
*   License: MIT License                                                            *
*                                                                                   *
*   Permission is hereby granted, free of charge, to any person obtaining           *
*   a copy of this software and associated documentation files (the "Software"),    *
*   to deal in the Software without restriction, including without limitation       *
*   the rights to use, copy, modify, merge, publish, distribute, sublicense,        *
*   and/or sell copies of the Software, and to permit persons to whom the           *
*   Software is furnished to do so, subject to the following conditions:            *
*                                                                                   *
*   The above copyright notice and this permission notice shall be included in      *
*   all copies or substantial portions of the Software.                             *
*                                                                                   *
*   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      *
*   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        *
*   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     *
*   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          *
*   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   *
*   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   *
*   SOFTWARE.                                                                       *
*                                                                                   *
*************************************************************************************/

#ifndef RTTR_METADATA_CONTAINER_H_
#define RTTR_METADATA_CONTAINER_H_

#include "rttr/base/core_prerequisites.h"
#include "rttr/variant.h"

#include <string>
#include <unordered_map>

namespace rttr
{
namespace detail
{

/*!
 * This class gives access to a constructor of a rttr::type.
 * Discovers the attributes of a class constructor and provides access to constructor metadata. 
 * 
 * Calling constructor::invoke will create an instance of the type.
 */
class RTTR_API metadata_container
{
    public:
        metadata_container()
        {}

        metadata_container(metadata_container&& other)
        :   m_int_data(std::move(other.m_int_data)),
            m_string_data(std::move(other.m_string_data))
        {
        }

        variant get_metadata(int key) const;
        variant get_metadata(const std::string& key) const;

        void set_metadata(int key, variant value);
        void set_metadata(std::string key, variant value);

    private:
        typedef std::unordered_map<int, variant> IntKey2ValueMap;
        typedef std::unordered_map<std::string, variant> StringKey2ValueMap;
        IntKey2ValueMap     m_int_data;
        StringKey2ValueMap  m_string_data;
};

} // end namespace detail
} // end namespace rttr

#endif // RTTR_METADATA_CONTAINER_H_
