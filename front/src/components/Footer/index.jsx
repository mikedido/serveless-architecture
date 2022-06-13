import styled from 'styled-components';

const FooterContainer = styled.footer`
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    padding-top: 60px;
`

function Footer() {
    return (
        <FooterContainer>
            <div>This is the footer</div>
        </FooterContainer>
    )
}

export default Footer;