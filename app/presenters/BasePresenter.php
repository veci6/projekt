<?php

namespace App\Presenters;

use App\Model\Entities\User as UserEntity;
use App\Model\Facades\UserFacade;
use Kdyby\Translation\Translator;
use Nette\Application\UI\Presenter;
use Nette\Bridges\ApplicationLatte\Template;

/**
 * Základní presenter pro všechny ostatní presentery aplikace.
 * @package App\Presenters
 */
abstract class BasePresenter extends Presenter {

    /** @persistent null|string Určuje jazykovou verzi webu. */
    public $locale;

    /**
     * @var \Kdyby\Translation\Translator Obstarává jazykový překlad na
      úrovni presenteru.
     * @inject
     */
    public $translator;
    public $userFacade;

    /** @var UserEntity Entita pro aktuálního uživatele. */
    protected $userEntity;

    /**
     * Registrace makra na překlad.
     * @inheritdoc
     */
    protected function createTemplate() {
        /** @var Template $template Latte šablona pro aktuální presenter.
         */
        $template = parent::createTemplate();
        $this->translator->createTemplateHelpers()->register($template->getLatte());
        return $template;
    }

    /**
     * Volá se na začátku každé akce, každého presenteru a zajišťuje
      inicializaci entity uživatele.
     */
    public function startup() {
        parent::startup();
        if ($this->getUser()->isLoggedIn()) {
            $this->userEntity = $this->userFacade->getUser($this->getUser()->getId());
        } else {
            // Abychom mohli použít "$userEntity->isAdmin()", když uživatel není přihlášen .
            $entity = new UserEntity();
            $entity->role = UserEntity::ROLE_USER;
            $this->userEntity = $entity;
        }
    }

    /**
     * Volá se před vykreslením každého presenteru a předává společné proměnné
      do celkového layoutu webu.
     */
    public function beforeRender() {
        parent::beforeRender();
        $this->template->userEntity = $this->userEntity;
    }

}
