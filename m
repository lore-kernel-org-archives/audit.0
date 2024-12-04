Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3A1F667F;
	Wed,  4 Dec 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320469; cv=none; b=tGZEJMB5BWw4Hi4pUraOUEuGQ/oTGuq3Y9QCSYUxCe3vX+c8pxWHJPFD8bPlQKqOX9YbqgrzWc4Ofvh/tL/Focl+P9ZidClHkkcf44DbQiCSm/hzsUDb/gfBoK3QAfqye8yQ/8gj+6ARq+1OaXj0DOubQJHW1QexYtRwFnGZktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320469; c=relaxed/simple;
	bh=glB2djWeXag327qCP/wXVgxmC14NcW9oTf9ZFLlGMNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChEXVmt+LoEhgyf94sYcKTx7qjvdleTiRwkCl6VhS/ZdCXy65Hi86VHPVn6VNBGugX32+i4JnT6WBRAQGCOC4VvAep6cPxFpKNoixsohyDOxIvp99LDL7BKJS1DG3PKmta/8URiYULumrld37aXxq/80sMxVYGLUKhjnflNuzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDYdWGIn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDYdWGIn"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46686a258c2so57330421cf.2;
        Wed, 04 Dec 2024 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733320466; x=1733925266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RptwRUavW0SsrYigmdi9DJqiFrjgQ2+PoZGqM36Tnes=;
        b=nDYdWGIn9QXW4+tyYMp98WWE7jCY97SPRs3ybVj47HE9fcxrLwyyqlVln4Kx199LHW
         3aZZ5lYN5YrQzvPiIA5ZFvIZW3WjJtoGJHu+X9lTSCjzo2AK4C2FxdIOdCAGiu0SZKLv
         4KvDgFvVsEM29E3MrwzOhUU5ynMrwXYxRtmaALe1u7S3elKwvvYOXAB/cb4or1Jb1R3A
         jtmrlA+7gtl2mOwbkWGQnubxLWYYMohrgumSjXBMWDDpPgpIszVbocPGGYqoLOmLfdeJ
         njeNILZ7X5KhN1zMpDWpevmepLXcTJCCUyvBz1zyL4bPQ3wdx/xo0LR6o0tHsc/1FP1A
         jFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320466; x=1733925266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RptwRUavW0SsrYigmdi9DJqiFrjgQ2+PoZGqM36Tnes=;
        b=Kh8/EjFCCFEAe2eWSEHzVGCH+ER1a5pg/wNaqkjmfuzACmQNhpgAgYnTeDf3thxTZL
         DMHYa4FZZn6BK7dHkg4D4F8eJP9EYTXeJDyLKF5N7G6MURYRQsXejZARFmfL6LbhwCdE
         sGXrdXxIhSO6nH/VELhuPkCqCvFMdg9RBXxhLslZZVIaQPG3ywufYjo2xjLDz4Zw/sSl
         eYBjG8qpNsztbGxgvikg/QBhvww7nUagZCicmoIMkndEtPwyc3lyCk4vbFKfxnJ76EE4
         gHT3Ep3QIQNUslnmZnJNpQOgeop2h62qoRARnZwE/On1ignGkn2lfxQNGX53JkgXxXBG
         Mr0w==
X-Forwarded-Encrypted: i=1; AJvYcCVLBJwseCMhkmcug3Ph6A8lSgdBU0G+IXb1/MNF2ufqfYpCFnBBQqJ81eZeCoYMBh6ry88h5XgyxtfE00Xw@vger.kernel.org, AJvYcCX9F+8ZmeU8wzKmYKMy6PZLrry54sIm2tua2KzsyV/W0DSPCmLmgrfx/Lbby85cTVwuc2DzUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysQUxPyRTXpJW/+DxzntJO9PvPmuvCViVPm8GVPMm+WFfIkstr
	kZUgrYC8jVhKxKOFYNKm1wKvy0XjEszBDs63sAuFkwSgykVTy0rrx8riy5fRWLtjjxTg1BWtgG6
	w3HwAmKQYjF1mqu/TF/CqQ/4bSk0=
X-Gm-Gg: ASbGnctqLGiDW9n4lvnoESEbceUMPXuNkA/rMmuTGPbWpZcNRrzuwHmCUGC96dlOoV9
	yVAoeCZDLBsL3iOH0PKvxfVqd49TiiBz/
X-Google-Smtp-Source: AGHT+IEGXPgm+w6l+jXcgmNgGIg5E/Grvio5jopOy18S00FmbnC1mKUG9PARRRF+/t4dmbFLDflbqcH9aPH/PQ3orjw=
X-Received: by 2002:a05:620a:2416:b0:7b1:f1d:d0c2 with SMTP id
 af79cd13be357-7b6a5d66510mr794665985a.19.1733320466168; Wed, 04 Dec 2024
 05:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203060350.69472-1-laoar.shao@gmail.com> <CAHC9VhTRaX02x+KFpsxmguze3R=AAF9yjTtDxf_ghVpQ3XdU2A@mail.gmail.com>
 <CALOAHbDgb5LW+XF1_VHGpr7zcjenMwSQzOy-pTsyV3buOW1N6Q@mail.gmail.com>
 <CAHC9VhSA7U5D0mzg+OmGi5RpDpw-+eufyTEDtLu9m=nkMHe+yA@mail.gmail.com> <CALOAHbBH8p3Xp2JdajHKWzfWxtMvgA_XTBoqi8RVUV1meveFZQ@mail.gmail.com>
In-Reply-To: <CALOAHbBH8p3Xp2JdajHKWzfWxtMvgA_XTBoqi8RVUV1meveFZQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Dec 2024 21:53:50 +0800
Message-ID: <CALOAHbDZ69ZoCwHXkR=iBfLf_pXwLYQW-3LY8OogB0EpbEPzbw@mail.gmail.com>
Subject: Re: [PATCH] auditsc: Implement a workaround for a GCC bug triggered
 by task comm changes
To: Paul Moore <paul@paul-moore.com>
Cc: keescook@chromium.org, qiuxu.zhuo@intel.com, rostedt@goodmis.org, 
	lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:07=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, Dec 4, 2024 at 11:43=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Tue, Dec 3, 2024 at 10:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > > On Wed, Dec 4, 2024 at 6:06=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Dec 3, 2024 at 1:04=E2=80=AFAM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > >
> > > > > From: Yafang shao <laoar.shao@gmail.com>
> > > > >
> > > > > A build failure has been reported with the following details:
> > > > >
> > > > >    In file included from include/linux/string.h:390,
> > > > >                     from include/linux/bitmap.h:13,
> > > > >                     from include/linux/cpumask.h:12,
> > > > >                     from include/linux/smp.h:13,
> > > > >                     from include/linux/lockdep.h:14,
> > > > >                     from include/linux/spinlock.h:63,
> > > > >                     from include/linux/wait.h:9,
> > > > >                     from include/linux/wait_bit.h:8,
> > > > >                     from include/linux/fs.h:6,
> > > > >                     from kernel/auditsc.c:37:
> > > > >    In function 'sized_strscpy',
> > > > >        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> > > > > >> include/linux/fortify-string.h:293:17: error: call to '__write=
_overflow' declared with attribute error: detected write beyond size of obj=
ect (1st parameter)
> > > > >      293 |                 __write_overflow();
> > > > >          |                 ^~~~~~~~~~~~~~~~~~
> > > > >    In function 'sized_strscpy',
> > > > >        inlined from 'audit_signal_info_syscall' at kernel/auditsc=
.c:2759:3:
> > > > > >> include/linux/fortify-string.h:293:17: error: call to '__write=
_overflow' declared with attribute error: detected write beyond size of obj=
ect (1st parameter)
> > > > >      293 |                 __write_overflow();
> > > > >          |                 ^~~~~~~~~~~~~~~~~~
> > > > >
> > > > > The issue appears to be a GCC bug, though the root cause remains
> > > > > unclear at this time. For now, let's implement a workaround.
> > > > >
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00IC=
VG-lkp@intel.com/
> > > > > Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > > > Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@ganda=
lf.local.home/
> > > > > Reported-by: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
> > > > > Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17D=
AFF389362@CY8PR11MB7134.namprd11.prod.outlook.com/
> > > > > Originally-by: Kees Cook <kees@kernel.org>
> > > > > Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395=
030@keescook/
> > > > > Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> > > > > Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > > > ---
> > > > >  kernel/auditsc.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > Thanks, does anyone have a link to the GCC bug report?  We really
> > > > should mention that in the commit description and/or metadata.
> > >
> > > I came across a GCC bug report [0] while researching online. This
> > > issue was reportedly fixed in GCC-12.1 [1], yet it seems the same bug
> > > is still being triggered in GCC-14.2.0[2].
> > > Should I file a new bug report with GCC to address this?
> >
> > I was under the impression that this had already been reported, if it
> > hasn't, then yes, please report the bug to the GCC team so we can get
> > this fixed.  Once you have the bug report, please post it here so it
> > can be included in the commit.
>
> Sure, I=E2=80=99ll file a new report. However, it seems I need to create =
a new
> account for the bug tracker and wait for its approval. Please bear
> with me=E2=80=94I=E2=80=99ll provide an update as soon as it=E2=80=99s co=
mpleted.

JFYI, the bug report has been filed:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117912

--=20
Regards
Yafang
