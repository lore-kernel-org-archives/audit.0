Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248037CAF
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W0sdrGfX"
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE6C2
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 08:44:28 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso3633105276.3
        for <audit@vger.kernel.org>; Tue, 24 Oct 2023 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698162267; x=1698767067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNUC1bN/lPZpYJJTCpt+p86VSRMczCoTnYfmB/OCd54=;
        b=W0sdrGfXNMayEWoZFtYoy1XK0BLF/0pxT61Ht1A3xyeIo+rEjI48jv4TaB5ijzOTU2
         3pfnaAcREqUwpEp7ygbqPGQ/kkKflpzG/rVcfYN4wkN/oGh3Ad9yX2I+OxsfToUydtZD
         rs1io8AbGrVoNUVyEN5u+fppfr/IKdGgG7IbvWB2tj8/avBntNZKZjI5D6P8fEMj77AJ
         ZARFxZXybBV2pY3CzPqY2w+Efq0CqEheWxPlAifXoKVgjY9nnvIW761MFEIS/MK1o3oz
         eGXWSJxePNKLwismzFezEtDCggugVTD70i3o+FqzPGm6WD2wDcUgtugn/M/yxz71IpWl
         g0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698162267; x=1698767067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNUC1bN/lPZpYJJTCpt+p86VSRMczCoTnYfmB/OCd54=;
        b=ou0Jzwn5olVa28p45OYgL39phoJW/BEusCbd9X1pi53FbCNM2n4mIFJqKYt3d6LQ1t
         QWI21aY4Py/wxSJUCEX3nuwrrKdJdi4g6bYt+DadP4Ufhv3zOdaaLikl7VdtKMASsqOa
         77b2Nn7e2IYreGFXiQOHA0lP/5wldQyv9EJ+P6k0bmuQiKjwsFqYJrp2TPKsKLVxM1jV
         RlB6rjH8IUTyYs98uKaM6et2bq3qsCjT2Q6qCNamwvp629PwxgP6j1VlWhxmUNpiRmhj
         fNe5ygpYRnybDZSMr82lB42UX5xW/gSXhA2vHG3TQsrDFikXbRM91VM4Ua50lx0mtpNH
         mEQg==
X-Gm-Message-State: AOJu0Ywx4K2RVTdkIXo8R2X8zx/TipgsOtOdz6igZHDKJ2LMUOfJfwY4
	D0D010pNWbOIk9dvHzhWhN3hJrobr6eTIZXxnb9U
X-Google-Smtp-Source: AGHT+IHJyDeDMBKAKQfnE3Ex3rU6tW5rrEbHBCp2q2WeKSoRN1RTOSWPERaznBWF8W82jyj0tBAmsGd4K73+iApP7Y4=
X-Received: by 2002:a25:abc9:0:b0:da0:47b0:5241 with SMTP id
 v67-20020a25abc9000000b00da047b05241mr1729056ybi.34.1698162267408; Tue, 24
 Oct 2023 08:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
 <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
 <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com>
 <CAGudoHHqP6oMcQO8MCx47a0vwv8a8Nb1tHn-kJAj4iFa+Anf2A@mail.gmail.com>
 <CAHC9VhQDE43vwe2UAQCYeXuAQcdOj-evsie=spit-oXcekwNkw@mail.gmail.com>
 <CAGudoHH5R_zNf0uLPSB+_o0N8bU2g29L6Nrz8Yo-KhG2Vot_ew@mail.gmail.com>
 <CAHC9VhQy6w6=ndC-8nY+tjM_A3bfGFoeDqViaxeFokH0FF4XdQ@mail.gmail.com> <CAGudoHHwH1nJzQfS1OynoKmp--58CtiVB+BX9j46K6hwYxvJeA@mail.gmail.com>
In-Reply-To: <CAGudoHHwH1nJzQfS1OynoKmp--58CtiVB+BX9j46K6hwYxvJeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Oct 2023 11:44:15 -0400
Message-ID: <CAHC9VhQPCX_OoNgXUR--gjx8Pi2be=h1swt4cSOKnJA0aAdjLg@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: audit@vger.kernel.org, Andreas Steinmetz <anstein99@googlemail.com>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 9:51=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Oct 19, 2023 at 12:56=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> >> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> >> > On Thu, Oct 19, 2023 at 10:52=E2=80=AFAM Mateusz Guzik <mjguzik@gmai=
l.com>
> >> > wrote:
> >> >> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> >> >> > Thinking about it a bit more this morning, I think we can safely
> >> >> > ignore the non-@current case in audit_exe_compare() as the whole
> >> >> > point
> >> >> > of the audit exe filter is to record the actions of processes
> >> >> > instantiated from that executable file; if the @current task is n=
ot
> >> >> > being logged/filtered, we shouldn't have to worry about the exe
> >> >> > filter.
> >> >>
> >> >> I did a quick stab at figuring out whether one can get there with
> >> >> non-current to begin with, but did not convince myself it is not
> >> >> possible.
> >> >>
> >> >> That said, should you repost, I think refing and unrefing mm should=
 be
> >> >> a
> >> >> voided.
> >> >
> >> > We have to deref current->mm to get the exe_file, but so long as we
> >> > get a reference with mmget()/mmput() it should be safe, no?
> >>
> >> For task =3D=3D current the very condition which allows you to safely
> >> mmget also makes the operation redundant -- current already has a ref
> >> on mm for as long as it executes.
> >
> > I've been using the move_pages(2) syscall code as an example and in
> > the find_mm_struct() function the code either does a mmget() if
> > accessing current->mm or a get_task_mm() if accessing an arbitrary
> > task.
> >
> >   -> SYSCALL_DEFINE6(move_pages, ...)
> >     -> kernel_move_pages(...)
> >       -> find_mm_struct(...)
> >
> > What am I missing?
> >
>
> To my reading they did not want to special-case it in the caller --
> they just mmput regardless of what task is.
>
> Again, you may notice there are no locks held in that usecase. The
> pointer is blindly derefed and a refcount bumped. For this to be safe,
> it has to be guaranteed > 0 already, which it is for a task accessing
> it's own mm struct. You can find the releasing mmput in exit ->
> do_exit -> exit_mm callchain.

I'll have a v2 out soon (later today?).

--=20
paul-moore.com
