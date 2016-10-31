<?php

namespace App\Model\Entities;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * Doctrine entita pro tabulku user.
 * @package App\Model\Entities
 * @ORM\Entity
 */
class User extends BaseEntity {

    // Pomocné konstanty pro náš model.
    /** Konstanty pro uživatelské role. */
    const ROLE_USER = 1,
            ROLE_ADMIN = 2;

    /** Konstanty pro uživatelské jméno. */
    const MAX_NAME_LENGTH = 15,
            NAME_FORMAT = "^[a-zA-Z0-9]*$";

    // Proměné reprezentující jednotlivé sloupce tabulky.
    /**
     * Sloupec pro ID uživatele.
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue
     */
    protected $id;

    /**
     * Sloupec pro jméno.
     * @ORM\Column(type="string")
     */
    protected $name;

    /**
     * Sloupec pro heslo.
     * @ORM\Column(type="string")
     */
    protected $password;

    /**
     * Sloupec pro email.
     * @ORM\Column(type="string")
     */
    protected $email;

    /**
     * Sloupec pro IP adresu.
     * @ORM\Column(type="string")
     */
    protected $ip;

    /**
     * Sloupec pro datum registrace.
     * @ORM\Column(name="`registration_date`", type="datetime")
     */
    protected $registrationDate;

    /**
     * Sloupec role uživatele. Význam hodnot viz. konstanty pro
      uživatelské role.
     * @ORM\Column(type="integer")
     */
    protected $role;

    /**
     * Ověřuje, zda je uživatel v roli administrátora.
     * @return bool vrací true, pokud je uživatel administrátor; jinak
      vrací false
     */
    public function isAdmin() {
        return $this->role === self::ROLE_ADMIN;
    }

}
