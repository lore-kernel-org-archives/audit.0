Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DA32F765
	for <audit@vger.kernel.org>; Wed,  8 Jul 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535964; cv=pass; b=R3dLTsi4FDTQJq5s6m9IfvJ7TjCSwZMO2Idc2M5cGCPebJxyxXC8D/dqs7nf/AAkzq31UlLXrMEL1mVh9eIyilQwBZe1YlQjd+wo44nTI8y21HgP0LTIeQSFmtsECotFzNlKtt3wLoZObPOJbkqIWTieydkLgeDX4HuwbR7ir+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535964; c=relaxed/simple;
	bh=c3cUMPycIthFm5eN5Dw/xA8VZfZ1Cc4kpX6g1gpgWa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7a5qt+xLQ+qDYgGe2t2XB8wM50D+W8xIz2Jn0mAaT7JzCPznNc3sa/umeMDfpKsrxjB7lg4kFfzhV1EMn/h7P0usO7APDoXV+KfbfrTXk//1bFxbskDGEZQMOjoTWHLt8lKtZVjA38JGr535Af1ttrpviUeSr+iWSOluXzXjeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OZOBUFi2; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OZOBUFi2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso11177655ad.2
        for <audit@vger.kernel.org>; Wed, 08 Jul 2026 11:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783535962; cv=none;
        d=google.com; s=arc-20260327;
        b=JHC2Y0WxkCDipGfTKqNlQqwfwhCjFxnImTHSORV7t1Nf/GrH++zJ8PesYmowW80XNU
         J0Q0lyZ065SWcMuFT0gNn+104exDaf442PzqI2PJomC9fIIiyFjTN4bwJJBPCBXqFCpL
         woAVoNsWn6eHZEgPBi39J74DE5F9nh/FnQPW6PxvkbeJ77Nt5VYnL78HS9C4ooKJ2u91
         T0MMoCnkaqZXkC1kLudpVyiMbU6W35l++/AJQcw9860fYq0m2YZJJ8SunGGuD3pSgcQS
         sgX9EMDrCR4t6Cfhi8KXItcWDKILvoeIi/4bZxmNp2UJgiJdKtinI+kLKxJENo6svMvu
         DX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FO6fRPnytPJsy9hAepaBBlcDqYaDGVgFnlUAoMBAKps=;
        fh=dvfm21kR7693Z1EEt9alKp/JhHr2OqEHCc3wE9KTWHI=;
        b=DAR71DEodSn3fl3vpCyfsVDk/hA8jlW2j1nahkakUP06/N8bvw6HrnX2vOVE3jutIj
         RWz3BAIykOdQlznsaKl0DBuwXvJw12W/Oo8Ru9u/o+qMwgYnhbybS4LZoQKEG5HD9YCF
         ccBjyDkM55KbjRXvi0SE3IxawQj65BKlhbEGOH+me0jkkCkAtAmuHJ80Wslv/is24bm8
         xLw7HTvPzdX3PEJS8RPe/50u367Ey2WELta/g/mORJ6seo5PbdJMHndhyEFzc8H1N8uB
         gWGzvB3+gPxyl614VGlArZ0CbyKwUx3Be8ZEd53CfuveUPRgs36iiV1MQLpwSMRKFVSR
         cqnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783535962; x=1784140762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FO6fRPnytPJsy9hAepaBBlcDqYaDGVgFnlUAoMBAKps=;
        b=OZOBUFi2nOxOyWFF6X5PcisOuYDaA9thqv2n/j7r55Buh2PMzjx+HxrdjZGeKfNEWK
         71umOK/lDiyfp5jZ4vcfEQ7Y6mDYOWTbtpETCpBRuTOfpGEaXXf0Q3EADYhEXMEcY/Bu
         A41jFsS7O+nxGmaRJLFKvNEIlWLgMr538FXSrqa7nZEhaDDPPtb2YK0uN98wWkWb4J01
         C5OY/IAj6HsFmQxcouZZjV521KdQoQQv3EmD5qWFzkvjKZjfAFogNCmRpMkA+4smsfB6
         Re3m6rRGOG/miZCLw1vLLeQF/BswiuTWpgQX0szf2kz4q+kvIzSjbx9VboeQSXxacN6z
         VECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535962; x=1784140762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO6fRPnytPJsy9hAepaBBlcDqYaDGVgFnlUAoMBAKps=;
        b=TLbFc//EVdtyomcJP5y/OD3Eb3hC6o0RAdFZRx3LgDRvWfPxjpO/DTi5+zZ7WVlOAc
         T2u3On8imIdzIeefN8gK3TDk4clJirs6CjLe57QlQNKMMbLe00GIZhaG1TKin0+hHd9k
         C0J+Ti8p4oGw9wNznRVIQ8U0X9AwOU/NkLxIetn0s0zD/AzLmBjCXG1ClrVGZwcJKiwR
         Q1BsLm2WNnuidVXYBsSDFFEiOBAKRl87mWrzoGAW4revOOosg68P+H3yUjnxKoHjHCEN
         xsP9bJAQlFrT7AN/Zf8J5awaXTRqpw+zM7Fn1XY/lFm5XE6sGApy9wUoWM6dzKV4VxGO
         kiXw==
X-Forwarded-Encrypted: i=1; AHgh+RqFOyI4VPFg2KNn9zX4H4XAxj1slZAe3q+FCEcyrdat0uh3xqrn6FMDGJ9R22uxLyfTiN8Czw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUPZ0xJK1Tkrg5gpe6PxTOqW+JDud2kqO1Qtgrt3OfRKgtcXx
	1L5X7OQAd4Ge0FqVF1gWoI4ZQBeDKe5G4Bmp1tRDO0U5zpgCTacR3VYLJP1fZ+s28Ry6tIYc3uh
	h0Sinzy5bvbhL8z5nc+FtPfnJtOrhII4nRFCCxnMM
X-Gm-Gg: AfdE7clMg1V6WDeI7M0OtdU3E0tNub3xgqoIKcDZSYBiatR53Wr1LhFsSN9UxgbRqyR
	8eE8tciNpvXYyJlxJS+VHmmUkNF23QBpWcHgNHoyFnA31jGtsMLSIvGnXv562+iMOadPNuGsUok
	x7RtwKfqOCmelwtw4AkxtHAvSyyteWAktBQXECxNvcfs7KLeatlVM6EWBJZcBIGGn4JtGU+k8dF
	3/7Cb22N07jf4XLdAgJZ3i148duz37CrCNNUtqG6+ozSINuJ8RjqDRAZv+01oqcO/mu32TU
X-Received: by 2002:a17:903:1247:b0:2ca:eea:eb5c with SMTP id
 d9443c01a7336-2ccea373170mr39018785ad.18.1783535961899; Wed, 08 Jul 2026
 11:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122548.1623981-2-rrobaina@redhat.com> <20260707-sippenhaft-teufel-bergbahn-87d9652bea7f@brauner>
In-Reply-To: <20260707-sippenhaft-teufel-bergbahn-87d9652bea7f@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 14:39:10 -0400
X-Gm-Features: AVVi8CcEwmTgxMe4KntKbfOspAEW6pn_CHMrD03qsp2cS17938sLsIdKxqVA-tw
Message-ID: <CAHC9VhTpoOaQhw293UNJ58TP5=qYuNNNvJSQ3tzT=uJ4MmXwXw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
To: Christian Brauner <brauner@kernel.org>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsopen syscall but
> > does not capture the filesystem name string, creating an audit gap for
> > filesystem mount operations.
> >
> > Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> > name string passed to fsopen(2).
> >
> >   type=3DSYSCALL ... : arch=3Dx86_64 syscall=3Dfsopen ... a1=3DFSOPEN_C=
LOEXEC
> >   type=3DFSOPEN  ... : fs_name=3D"tmpfs"
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
>
> I need a hint from the audit people whether this is ok or not...

It's in the queue to take a closer look, need to get the stable-7.2
stuff out first.

Are you okay with the VFS addition Christian?  If so, an ACK would be
appreciated as this is something we would want to merge via the audit
tree and not the VFS tree.

--=20
paul-moore.com
