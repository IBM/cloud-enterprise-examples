import React from "react";
import { Link } from "gatsby";

const XLink = ({ to, name }) => {
    const REGEX_INTERNAL_URL = "/^\/(?!\/)/";

    if (REGEX_INTERNAL_URL.test(to) ) {
        <Link to={to}>{name}</Link>
    } else {
        <a href={to}>{name} target="_blank"</a>
    }

}
export default XLink