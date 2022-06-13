import { Link } from 'react-router-dom'
import styled from 'styled-components'

const NavContainer = styled.nav`
  padding: 30px;
  display: flex;
  justify-content: space-between;
  align-items: center;
`
const StyledLink = styled(Link)`
    padding: 15px;
    color: #8186a0;
    text-decoration: none;
    font-size: 18px;
    border-radius: 30px;
`

function Header() {
    return (
        <NavContainer>
            <div>
                <StyledLink to="/" >Accueil</StyledLink>
                <StyledLink to="/get" >List</StyledLink>
                <StyledLink to="/put">Dépôt</StyledLink>
            </div>
        </NavContainer>
        
    )
}

export default Header;