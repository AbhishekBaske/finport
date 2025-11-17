import React, { useState, useEffect, useRef } from "react";
import styled from "styled-components";
import { gsap } from "gsap";
import { useAuth } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";

/* ────────────────────────────────────────────── */
/* Styled Components */
/* ────────────────────────────────────────────── */

const NAV_HEIGHT = "78px";

const Nav = styled.nav`
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: ${NAV_HEIGHT};
  z-index: 999;
  background: white;
  border-bottom: 1px solid #e5e7eb;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
  padding: 16px 32px;
  opacity: 0;
  transform: translateY(-30px);
`;

const Container = styled.div`
  max-width: 1200px;
  margin: auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
`;

const Logo = styled.a`
  font-size: 1.9rem;
  font-weight: 800;
  letter-spacing: -1px;
  text-decoration: none;
  background: linear-gradient(135deg, #4f46e5, #818cf8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
`;

const DesktopNav = styled.div`
  display: flex;
  gap: 26px;
  align-items: center;

  @media (max-width: 768px) {
    display: none;
  }
`;

const MobileToggle = styled.button`
  display: none;
  background: none;
  border: none;
  font-size: 1.9rem;
  cursor: pointer;

  @media (max-width: 768px) {
    display: block;
  }
`;

const MobileMenu = styled.div`
  padding: 20px;
  border-top: 1px solid #eee;
  background: white;
  display: flex;
  flex-direction: column;
  gap: 14px;
  opacity: 0;
`;

const NavLink = styled.a`
  text-decoration: none;
  padding: 8px 14px;
  border-radius: 8px;
  font-weight: 500;
  font-size: 0.95rem;
  color: #4b5563;
  transition: 0.25s;

  &:hover {
    color: #4f46e5;
    transform: translateY(-2px);
    background: rgba(79, 70, 229, 0.1);
  }
`;

const CTAButton = styled.button`
  background: #4f46e5;
  color: white;
  font-weight: 600;
  padding: 10px 22px;
  border-radius: 12px;
  border: none;
  cursor: pointer;
  font-size: 0.95rem;
  transition: 0.25s;

  &:hover {
    background: #4338ca;
    transform: translateY(-2px);
  }
`;

const LogoutButton = styled.button`
  background: transparent;
  border: 1px solid #ff6b6b;
  color: #ff6b6b;
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 0.9rem;
  cursor: pointer;
  transition: 0.25s;

  &:hover {
    background: #ff6b6b;
    color: white;
    transform: translateY(-2px);
  }
`;

const Welcome = styled.span`
  font-size: 0.9rem;
  font-weight: 600;
  color: #4f46e5;
`;

/* ────────────────────────────────────────────── */
/* Component */
/* ────────────────────────────────────────────── */

const Navbar: React.FC = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const { isAuthenticated, user, logout } = useAuth();
  const navigate = useNavigate();

  const navRef = useRef<HTMLDivElement>(null);
  const menuRef = useRef<HTMLDivElement>(null);

  /* FADE-IN */
  useEffect(() => {
    gsap.to(navRef.current, {
      opacity: 1,
      y: 0,
      duration: 0.7,
      ease: "power3.out",
    });
  }, []);

  /* SCROLL HIDE / SHOW */
  useEffect(() => {
    let last = window.scrollY;

    const handler = () => {
      const curr = window.scrollY;

      gsap.to(navRef.current, {
        y: curr > last ? -90 : 0,
        duration: 0.35,
        ease: "power3.out",
      });

      last = curr;
    };

    window.addEventListener("scroll", handler);
    return () => window.removeEventListener("scroll", handler);
  }, []);

  /* Mobile menu animation */
  useEffect(() => {
    gsap.to(menuRef.current, {
      opacity: isMenuOpen ? 1 : 0,
      height: isMenuOpen ? "auto" : 0,
      duration: 0.25,
      ease: "power2.out",
    });
  }, [isMenuOpen]);

  const handleLogout = async () => {
    await logout();
    navigate("/");
  };

  return (
    <Nav ref={navRef}>
      <Container>
        <Logo href="/">📈 Finport</Logo>

        <DesktopNav>
          <NavLink href="/">Home</NavLink>
          {isAuthenticated && <NavLink href="/dashboard">Dashboard</NavLink>}

          {isAuthenticated ? (
            <>
              <Welcome>Welcome, {user?.name}</Welcome>
              <LogoutButton onClick={handleLogout}>Logout</LogoutButton>
            </>
          ) : (
            <>
              <NavLink href="/signin">Sign In</NavLink>
              <a href="/signup">
                <CTAButton>Get Started</CTAButton>
              </a>
            </>
          )}
        </DesktopNav>

        <MobileToggle onClick={() => setIsMenuOpen(!isMenuOpen)}>☰</MobileToggle>
      </Container>

      <MobileMenu ref={menuRef}>
        <NavLink href="/">Home</NavLink>
        {isAuthenticated && <NavLink href="/dashboard">Dashboard</NavLink>}

        {isAuthenticated ? (
          <>
            <Welcome>Welcome, {user?.name}</Welcome>
            <LogoutButton onClick={handleLogout}>Logout</LogoutButton>
          </>
        ) : (
          <>
            <NavLink href="/signin">Sign In</NavLink>
            <a href="/signup">
              <CTAButton>Get Started</CTAButton>
            </a>
          </>
        )}
      </MobileMenu>
    </Nav>
  );
};

export default Navbar;
